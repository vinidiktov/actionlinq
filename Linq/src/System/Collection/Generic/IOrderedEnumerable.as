package System.Collection.Generic
{
	public interface IOrderedEnumerable extends IEnumerable
	{
		/**
		 * Performs a subsequent ordering on the elements of an IOrderedEnumerable according to a key.
		 * 
		 * @return An IOrderedEnumerable whose elements are sorted according to a key.
		 * 
		 * @param keySelector The function used to extract the key for each element.
		 * @param comparer The IComparer used to compare keys for placement in the returned sequence.
		 * @param descending true to sort the elements in descending order; false to sort the elements in ascending order.
		 */
		function createOrderedEnumerable(keySelector:Function, comparer:IComparer, descending:Boolean):IOrderedEnumerable;
		
		/**
		 * Performs a subsequent ordering of the elements in a sequence in descending order by using an optional comparer.
		 * 
		 * @return An IOrderedEnumerable whose elements are sorted in descending order according to a key.
		 * 
		 * @param keySelector A function to extract a key from each element.
		 * @param comparer An IComparer to compare keys.
		 * 
		 * @throws ArgumentError when keySelector is null
		 * 
		 * @see thenByDescending
		 * @see IEnumerable.orderBy
		 * @see IEnumerable.orderByDescending
		 */
		function thenBy(keySelector:Function, comparer:IComparer=null):IOrderedEnumerable;
		
		// ThenByDescending
	}
}