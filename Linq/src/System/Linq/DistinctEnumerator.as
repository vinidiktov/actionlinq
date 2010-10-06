package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	public class DistinctEnumerator implements IEnumerator
	{
		private var enumerator:IEnumerator;
		private var visited:Array = [];
		private var current:*;
		
		public function DistinctEnumerator(enumerable:IEnumerable)
		{
			this.enumerator = enumerable.GetEnumerator(); 
		}
		
		public function MoveNext():Boolean
		{
			while(enumerator.MoveNext()) {
				var possibleCurrent:* = enumerator.Current();
				
				if(visited.indexOf(possibleCurrent) < 0) {
					current = possibleCurrent;
					visited.push(current);
					return true;
				}
			}
			
			visited = [];
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