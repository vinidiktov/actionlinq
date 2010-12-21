package System.Collection.Generic
{
	import System.Linq.*;
	import System.Linq.Option.Option;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;

	public interface IEnumerable
	{
		function GetEnumerator():IEnumerator; 
		
		function Where(predicate:Function):IEnumerable;		
		function Select(selector:Function):IEnumerable;
		function SelectMany(selector:Function, resultsSelector:Function = null):IEnumerable;
		function Take(count:int):IEnumerable;
		function TakeWhile(predicate:Function):IEnumerable;
		function Skip(count:int):IEnumerable; 
		function SkipWhile(predicate:Function):IEnumerable;

		/**
		 * Correlates the elements of two sequences based on matching keys. The default equality comparer is used to compare keys.
		 * 
		 * @return An IEnumerable that has elements of type TResult that are obtained by performing an inner join on two sequences.
		 * 
		 * @param inner The sequence to join to the first sequence.
		 * @param outerKeySelector A function to extract the join key from each element of the first sequence.
		 * @param innerKeySelector A function to extract the join key from each element of the second sequence.
		 * @param resultSelector A function to create a result element from two matching elements.
		 * 
		 * @throws ArgumentError when inner or outerKeySelector or innerKeySelector or resultSelector is null.
		 */
		function join(inner:IEnumerable, outerKeySelector:Function, innerKeySelector:Function, resultSelector:Function):IEnumerable;
		
		function groupJoin(inner:IEnumerable, outerKeySelector:Function, innerKeySelector:Function, resultSelector:Function):IEnumerable;
		
		function orderBy(keySelector:Function):IOrderedEnumerable;
		//* IOrderedEnumerable<TSource> OrderBy<TSource, TKey>(Func<TSource, TKey> keySelector);
		//IOrderedEnumerable<TSource> OrderBy<TSource, TKey>(Func<TSource, TKey> keySelector, IComparer<TKey> comparer);
		
		// OrderByDescending
		// ThenBy
		// ThenByDescending
		// GroupBy
		
		function Concat(second:IEnumerable):IEnumerable;
		function Zip(second:IEnumerable, resultSelector:Function):IEnumerable;
		function Distinct(comparer:IEqualityComparer=null):IEnumerable;
		function Union(second:IEnumerable, comparer:IEqualityComparer=null):IEnumerable;
		
		/**
		 * Produces the set intersection of two sequences by using the optional IEqualityComparer to compare values.
		 * 
		 * @return A sequence that contains the elements that form the set intersection of two sequences.
		 * 
		 * @param second An IEnumerable whose distinct elements that also appear in the first sequence will be returned.
		 * @param comparer An IEqualityComparer to compare values.
		 * 
		 * @throws ArgumentError if second is null
		 * 
		 * @see union
		 * @see except
		 */
		function intersect(second:IEnumerable, comparer:IEqualityComparer=null):IEnumerable;
		
		/**
		 * Produces the set difference of two sequences by using the optional IEqualityComparer to compare values.
		 * 
		 * @return A sequence that contains the set difference of the elements of two sequences.
		 * 
		 * @param second An IEnumerable whose elements that also occur in the first sequence will cause those elements to be removed from the returned sequence.
		 * @param comparer An IEqualityComparer to compare values.
		 * 
		 * @throws ArgumentError if second is null
		 * 
		 * @see union
		 * @see intersect
		 */
		function except(second:IEnumerable, comparer:IEqualityComparer=null):IEnumerable;
		
		/**
		 * Inverts the order of the elements in a sequence.
		 * 
		 * @return A sequence whose elements correspond to those of the input sequence in reverse order.
		 */
		function reverse():IEnumerable;
		
		/**
		 * Determines whether two sequences are equal by comparing their elements by using an optional IEqualityComparer
		 * 
		 * @return [code]true[/code] if the two source sequences are of equal length and their corresponding elements compare equal according to comparer; otherwise, [code]false[/code].
		 * 
		 * @param second An IEnumerable to compare to the sequence.
		 * @param comparer an IEqualityComparer to use to compare elements
		 * 
		 * @throws ArgumentError if second is null
		 */ 
		function sequenceEqual(second:IEnumerable, comparer:IEqualityComparer=null):Boolean;
		
		/**
		 * Creates an array from a IEnumerable
		 * 
		 * @return An array that contains the elements from the input sequence.
		 * 
		 * @see toArrayCollection
		 * @see toList
		 * @see toDictionary
		 */
		function toArray():Array;
		
		/**
		 * Creates an ArrayCollection from a IEnumerable
		 * 
		 * @return An ArrayCollection that contains the elements from the input sequence.
		 * 
		 * @see toArray
		 * @see toList
		 * @see toDictionary
		 */
		function toArrayCollection():ArrayCollection;
		
		/**
		 * Creates a List from a IEnumerable
		 * 
		 * @return A list that contains the elements from the input sequence.
		 * 
		 * @see toArrayCollection
		 * @see toArray
		 * @see toDictionary
		 */
		function toList():IList;
		
		/**
		 * Creates a Dictionary from an IEnumerable according to specified key selector and element selector functions.
		 * 
		 * @return A Dictionary that contains values selected from the input sequence.
		 * 
		 * @param keySelector A function to extract a key from each element.
		 * @param elementSelector A transform function to produce a result element value from each element.
		 * 
		 * @throws ArgumentError if keySelector is null
		 * @throws ArgumentError if keySelector returns a null key
		 * @throws ArgumentError if keySelector returns a duplicate key
		 * 
		 * @see toList
		 * @see toArray
		 * @see toArrayCollection
		 */ 
		function toDictionary(keySelector:Function, elementSelector:Function=null):Dictionary;
		
		/**
		 * Creates a Lookup from an IEnumerable according to specified key selector and (optional) element selector functions.
		 * 
		 * @return A Lookup that contains values selected from the input sequence.
		 * 
		 * @param keySelector A function to extract a key from each element.
		 * @param elementSelector A transform function to produce a result element value from each element.
		 * 
		 * @throws ArgumentError if keySelector is null
		 * @throws ArgumentError if keySelector returns a null key
		 * 
		 * @see toArray
		 * @see ToDictionary
		 * @see toArrayCollection
		 */
		function toLookup(keySelector:Function, elementSelector:Function=null):ILookup;
		
		/**
		 * Returns the elements of the specified sequence or the none if the sequence is empty.
		 * 
		 * @return None if source is empty; otherwise some IEnumerable
		 * 
		 * @see Any
		 */ 
		function noneIfEmpty():Option;
		
		/**
		 * Filters the elements of an IEnumerable based on a specified type.
		 * 
		 * @return An IEnumerable that contains elements from the input sequence of type TResult.
		 * 
		 * @param The type to filter the elements of the sequence on.
		 * 
		 * @see cast
		 * @see Where
		 */ 
		function ofType(type:Class):IEnumerable;
		
		/**
		 * Converts the elements of an IEnumerable to the specified type.
		 * 
		 * @return An IEnumerable that contains each element of the source sequence converted to the specified type.
		 * 
		 * @param type The type to convert the elements of source to.
		 * 
		 * @throws TypeError
		 * 
		 * @see Select
		 * @see ofType
		 */ 
		function cast(type:Class):IEnumerable;
		
		/**
		 * Returns the first element in a sequence that (optionally) satisfies a specified condition.
		 * 
		 * <p>first can be called in any of two overloads:
		 * <ul>
		 *   <li>first():*</li>
		 *   <li>first(predicate:Function):*</li>
		 * </ul>
		 * </p>
		 * 
		 * @return The first element in the sequence that passes the test in the specified predicate function.
		 * 
		 * @param predicate A function to test each element for a condition.
		 * 
		 * @throws RangeError when sequence is empty
		 * @throws RangeError when no element satisfies the condition in the predicate
		 *
		 * @see firstOrNone
		 * @see last
		 * @see lastOrNone
		 * @see single
		 * @see singleOrNone
		 * @see elementAt
		 * @see elementAtOrNone
		 */
		function first(predicate:Function=null):*;
		
		/**
		 * Returns the first element of the sequence that (optionally) satisfies a condition or none if no such element is found.
		 * 
		 * <p>firstOrNone can be called in any of two overloads:
		 * <ul>
		 *   <li>firstOrNone():*</li>
		 *   <li>firstOrNone(predicate:Function):*</li>
		 * </ul>
		 * </p>
		 * 
		 * @return The first element in the sequence that passes the test in the specified predicate function.
		 * 
		 * @param predicate A function to test each element for a condition.
		 *
		 * @see first
		 * @see last
		 * @see lastOrNone
		 * @see single
		 * @see singleOrNone
		 * @see elementAt
		 * @see elementAtOrNone
		 */
		function firstOrNone(predicate:Function=null):Option;
		
		/**
		 * Returns the last element in a sequence that (optionally) satisfies a specified condition.
		 * 
		 * <p>first can be called in any of two overloads:
		 * <ul>
		 *   <li>last():*</li>
		 *   <li>last(predicate:Function):*</li>
		 * </ul>
		 * </p>
		 * 
		 * @return The last element in the sequence that passes the test in the specified predicate function.
		 * 
		 * @param predicate A function to test each element for a condition.
		 * 
		 * @throws RangeError when sequence is empty
		 * @throws RangeError when no element satisfies the condition in the predicate
		 *
		 * @see first
		 * @see firstOrNone
		 * @see lastOrNone
		 * @see single
		 * @see singleOrNone
		 * @see elementAt
		 * @see elementAtOrNone
		 */
		function last(predicate:Function=null):*;
		
		/**
		 * Returns the last element of the sequence that (optionally) satisfies a condition or none if no such element is found.
		 * 
		 * <p>lastOrNone can be called in any of two overloads:
		 * <ul>
		 *   <li>lastOrNone():*</li>
		 *   <li>lastOrNone(predicate:Function):*</li>
		 * </ul>
		 * </p>
		 * 
		 * @return The last element in the sequence that passes the test in the specified predicate function.
		 * 
		 * @param predicate A function to test each element for a condition.
		 *
		 * @see first
		 * @see firstOrNone
		 * @see last
		 * @see single
		 * @see singleOrNone
		 * @see elementAt
		 * @see elementAtOrNone
		 */
		function lastOrNone(predicate:Function=null):Option;
		
		function Single(predicate:Function=null):*;
		function SingleOrNone(predicate:Function=null):Option;
		function ElementAt(index:int):*;
		function ElementAtOrNone(index:int):Option;
		function Any(predicate:Function=null):Boolean;
		function All(predicate:Function):Boolean;
		
		/**
		 * Returns the number of elements in a sequence
		 * 
		 * <p>Count can be called in any of two overloads:
		 * <ul>
		 *   <li>Count():int</li>
		 *   <li>Count(predicate:Function):int</li>
		 * </ul>
		 * </p>
		 * 
		 * @return The number of elements in the input sequence.
		 * 
		 * @param predicate A function to test each element for a condition.
		 * 
		 * @see First
		 * @see Last
		 * 
		 */ 
		function Count(predicate:Function=null):int;
		
		/**
		 * Determines whether a sequence contains a specified element, optionally using an eauality comparer
		 * 
		 * <p>Contains can be called in any of two overloads:
		 * <ul>
		 *   <li>Contains(value:*):Boolean</li>
		 *   <li>Contains(value:*, comparer:IEqualityComparer):Boolean</li>
		 * </ul>
		 * </p>
		 * 
		 * @return <code>true</code> if the source sequence contains an element that has the specified value; otherwise, <code>false</code>.
		 * 
		 * @param value The value to locate in the sequence.
		 * @param comparer An equality comparer to compare values.
		 * 
		 * @see Any
		 * @see All
		 */ 
		function Contains(value:*, comparer:IEqualityComparer=null):Boolean;
		
		/**
		 * Applies an accumulator function over a sequence.
		 * 
		 * <p>Aggregate can be called in any of three overloads:
		 * <ul>
		 *   <li>Aggregate(func:Function):*</li>
		 *   <li>Aggregate(seed:*, func:Function):*</li>
		 *   <li>Aggregate(seed:*, func:Function, resultSelector:Function):*</li>
		 * </ul></p> 
		 * 
		 * @return The final accumulator value.
		 * 
		 * @param funcOrSeed An accumulator function to be invoked on each element. OR The initial accumulator value.
		 * @param func An accumulator function to be invoked on each element.
		 * @param resultSelector A function to transform the final accumulator value into the result value.
		 * 
		 * @throws RangeError
		 * 
		 * @see Sum
		 * @see Min
		 * @see Max
		 * @see Average
		 */
		function Aggregate(funcOrSeed:*, func:Function=null, resultSelector:Function=null):*;
		
		/**
		 * Computes the sum of a sequence of values.
		 * 
		 * @return The sum of the projected values
		 * 
		 * @param selector A transform function to apply to each element.
		 * 
		 * @throws RangeError
		 * 
		 * @see Aggregate
		 * @see Average
		 */
		function Sum(selector:Function=null):*;
		
		/**
		 * Returns the minimum value in a sequence of values. 
		 * 
		 * @return The minimum value in the sequence.
		 * 
		 * @param selector A transform function to apply to each element.
		 * 
		 * @throws RangeError
		 * 
		 * @see Aggregate
		 * @see Max
		 */
		function Min(selector:Function=null):*;
		
		/**
		 * Returns the maximum value in a sequence of values. 
		 * 
		 * @return The maximum value in the sequence.
		 * 
		 * @param selector A transform function to apply to each element.
		 * 
		 * @throws RangeError
		 * 
		 * @see Aggregate
		 * @see Min
		 */
		function Max(selector:Function=null):*;
		
		/**
		 * Returns the average value in a sequence of values. 
		 * 
		 * @return The average value in the sequence.
		 * 
		 * @param selector A transform function to apply to each element.
		 * 
		 * @throws RangeError
		 * 
		 * @see Aggregate
		 * @see Sum
		 */
		function Average(selector:Function=null):*;
		
		/**
		 * Invokes an action on each value in a sequence
		 * 
		 * @param action The action to execute on each element in a sequence 
		 */
		function Each(action:Function):void;
	}
}