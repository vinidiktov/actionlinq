package System.Linq
{
	import System.Collection.Generic.IComparer;
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	public class OrderByEnumerator implements IEnumerator
	{
		
		
		private var enumerator:IEnumerable;
		private var comparisons:Array;
		private var sortedEnumerator:IEnumerator;
		private var descending:Boolean;
		
		public function OrderByEnumerator(enumerator:IEnumerable, comparisons:Array, descending:Boolean)
		{
			this.enumerator = enumerator;
			this.comparisons = comparisons;
			this.descending = descending;
		}
		
		private function getSortedEnumerator():IEnumerator {
			if(sortedEnumerator != null)
				return sortedEnumerator;
			
			var sortedArray:Array = enumerator.toArray();
			sortedArray.sort(sortFunction);
			sortedEnumerator = Enumerable.From(sortedArray).getEnumerator();
			return sortedEnumerator;
		}
		
		function sortFunction(a:*, b:*):Number {
			for each(var compare in comparisons)
			{
				var result = compare(a, b);
				if(result != 0)
					return result;
			}
			
			return 0;
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