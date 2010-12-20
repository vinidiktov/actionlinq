package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	import System.Collection.Generic.IEqualityComparer;
	
	public class IntersectEnumerator implements IEnumerator
	{
		private var first:IEnumerable;
		private var second:IEnumerator;
		private var firstCache:Array = null;
		private var comparer:IEqualityComparer = null;
		private var current:* = null;
		
		
		public function IntersectEnumerator(first:IEnumerable, second:IEnumerable, comparer:IEqualityComparer)
		{
			this.first = first;
			this.second = second.GetEnumerator();
			this.comparer = comparer;
		}
		
		private function populateFirstCache():void {
			if(firstCache != null)
				return;
			
			firstCache = first.toArray();
		}
		
		public function MoveNext():Boolean
		{
			populateFirstCache();
			
			while(second.MoveNext())
			{
				var possibleCurrent:* = second.Current();
				
				if(inFirst(possibleCurrent))
				{
					current = possibleCurrent;
					return true;
				}
			}
			
			return false;
		}
		
		private function inFirst(item:*):Boolean {
			if(comparer == null)
				return firstCache.indexOf(item) >= 0;
			
			for each(var firstItem:* in firstCache)
			  if(comparer.Equals(firstItem, item))
			  	return true;
			
			return false;
		}
		
		public function Current():*
		{
			return current;
		}
		
		public function Reset():void
		{
			second.Reset();
			firstCache = null;
			current = null;
		}
	}
}