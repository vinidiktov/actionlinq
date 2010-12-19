package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	public class OrderByEnumerator implements IEnumerator
	{
		private var enumerator:IEnumerable;
		private var keySelector:Function;
		private var sortedEnumerator:IEnumerator;
		
		public function OrderByEnumerator(enumerator:IEnumerable, keySelector:Function)
		{
			this.enumerator = enumerator;
			this.keySelector = keySelector;
		}
		
		private function getSortedEnumerator():IEnumerator {
			if(sortedEnumerator != null)
				return sortedEnumerator;
			
			var sortedArray:Array = enumerator.toArray();
			sortedArray.sort(sortFunction);
			sortedEnumerator = Enumerable.From(sortedArray).GetEnumerator();
			return sortedEnumerator;
		}
		
		function sortFunction(a:*, b:*):Number {
			var aKey:* = keySelector(a);
			var bKey:* = keySelector(b);
			
			if(aKey > bKey) {
				return 1;
			} else if(aKey < bKey) {
				return -1;
			} else  {
				return 0;
			}
		}
		
		public function MoveNext():Boolean
		{
			return getSortedEnumerator().MoveNext();
		}
		
		public function Current():*
		{
			return getSortedEnumerator().Current();
		}
		
		public function Reset():void
		{
			sortedEnumerator = null;
		}
	}
}