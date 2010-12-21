package System.Collection.Generic
{
	public interface IOrderedEnumerable extends IEnumerable
	{
		function createOrderedEnumerable(keySelector:Function, comparer:IComparer, descending:Boolean):IOrderedEnumerable;
	}
}