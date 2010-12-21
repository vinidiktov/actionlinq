package System.Linq
{
	import System.Collection.Generic.IComparer;
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	public class OrderByEnumerator implements IEnumerator
	{
		private var enumerator:IEnumerable;
		private var keySelector:Function;
		private var comparer:IComparer;
		private var sortedEnumerator:IEnumerator;
		private var descending:Boolean;
		
		public function OrderByEnumerator(enumerator:IEnumerable, keySelector:Function, comparer:IComparer, descending:Boolean)
		{
			this.enumerator = enumerator;
			this.keySelector = keySelector;
			this.comparer = comparer;
			this.descending = descending;
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
			
			var compared = compare(aKey, bKey);
			
			return compared * (descending ? -1 : 1);
		}
		
		private function compare(x:*, y:*):int {
			if(comparer != null)
				return comparer.compare(x, y);
			
			if(x > y) {
				return 1;
			} else if(x < y) {
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