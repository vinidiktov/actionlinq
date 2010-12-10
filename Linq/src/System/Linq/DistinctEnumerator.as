package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	import System.Collection.Generic.IEqualityComparer;
	
	public class DistinctEnumerator implements IEnumerator
	{
		private var enumerator:IEnumerator;
		private var comparer:IEqualityComparer;
		private var visited:Array = [];
		private var current:*;
		
		public function DistinctEnumerator(enumerable:IEnumerable, comparer:IEqualityComparer)
		{
			this.enumerator = enumerable.GetEnumerator(); 
			this.comparer = comparer;
		}
		
		public function MoveNext():Boolean
		{
			while(enumerator.MoveNext()) {
				var possibleCurrent:* = enumerator.Current();
				
				if(!haveVisited(possibleCurrent)) {
					current = possibleCurrent;
					visited.push(current);
					return true;
				}
			}
			
			visited = [];
			return false;
		}
		
		private function haveVisited(item:*):Boolean {
			if(comparer == null)
				return visited.indexOf(item) >= 0;
			
			for each(var visitedItem:* in visited)
			    if(comparer.Equals(visitedItem, item))
					return true;
				
			return false;
		}
		
		public function Current():*
		{
			return current;
		}
		
		public function Reset():void
		{
			enumerator.Reset();
			visited = [];
			current = null;
		}
	}
}