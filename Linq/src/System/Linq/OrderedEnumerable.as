package System.Linq
{
	import System.Collection.Generic.IComparer;
	import System.Collection.Generic.IEnumerator;
	import System.Collection.Generic.IOrderedEnumerable;

	public class OrderedEnumerable extends Enumerable implements IOrderedEnumerable
	{
		public function OrderedEnumerable(source:*, keySelector:Function, comparer:IComparer)
		{
			super(source, function(source:*):IEnumerator { return new OrderByEnumerator(source, keySelector, comparer) });
		}
		
		public function createOrderedEnumerable(keySelector:Function, comparer:IComparer, descending:Boolean):IOrderedEnumerable {
			return this;
		}
	}
}