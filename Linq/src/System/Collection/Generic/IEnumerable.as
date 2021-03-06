//Copyright 2010 SRT Solutions
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//	You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//	See the License for the specific language governing permissions and
//limitations under the License.

package System.Collection.Generic
{
	import System.Linq.*;
	import System.Linq.Option.Option;
	
	import flash.utils.Dictionary;
	
	import mx.core.FlexBitmap;
	
	COMPILE::FLEX
	{
		import mx.collections.ArrayCollection;
		import mx.collections.IList;
	}

	public interface IEnumerable
	{
		/**
		 * Returns an enumerator that iterates through a collection.
		 * 
		 * @return An IEnumerator object that can be used to iterate through the collection.
		 */
		function getEnumerator():IEnumerator; 
		
		/**
		 * Filters a sequence of values based on a predicate.
		 * 
		 * <p>predicate can be of two prototypes
		 * <ul>
		 *   <li>function(element:*):Boolean</li>
		 *   <li>function(element:*, index:int):Boolean</li>
		 * </ul>
		 * </p>
		 * 
		 * @return An IEnumerable that contains elements from the input sequence that satisfy the condition.
		 * 
		 * @param predicate A function to test each element for a condition.
		 * 
		 * @throws ArgumentError when predicate is null
		 */
		function where(predicate:Function):IEnumerable;		
		
		/**
		 * Projects each element of a sequence into a new form by optionally incorporating the element's index.
		 * 
		 * <p>selector can be of two prototypes
		 * <ul>
		 *   <li>function(element:*):*</li>
		 *   <li>function(element:*, index:int):*</li>
		 * </ul>
		 * </p>
		 * 
		 * @return An IEnumerable whose elements are the result of invoking the transform function on each element of source.
		 * 
		 * @param A transform function to apply to each source element; the second (if given) parameter of the function represents the index of the source element.
		 * 
		 * @throws ArgumentError if selector is null
		 * 
		 * @see selectMany
		 */
		function select(selector:Function):IEnumerable;
		
		/**
		 * Projects each element of a sequence to an IEnumerable, flattens the resulting sequences into one sequence, and invokes an optional result selector function on each element therein.
		 * 
		 * <p>selectMany can be called with two different overloads:
		 * <ul>
		 *   <li>selectMany(collectionSelector:Function):IEnumerable</li>
		 *   <li>selectMany(collectionSelector:Function, resultSelector:Function):IEnumerable</li>
		 * </ul></p>
		 * 
		 * <p>collectionSelector can be of two prototypes
		 * <ul>
		 *   <li>function(element:*):*</li>
		 *   <li>function(element:*, index:int):*</li>
		 * </ul>
		 * </p>
		 * 
		 * @return An IEnumerable whose elements are the result of invoking the one-to-many transform function collectionSelector on each element of source 
		 * and then mapping each of those sequence elements and their corresponding source element to a result element.
		 * 
		 * @param collectionSelector A transform function to apply to each element of the input sequence.
		 * @param resultSelector A transform function to apply to each element of the intermediate sequence.
		 * 
		 * @throws ArgumentException when collectionSelector is null
		 * 
		 * @see select
		 */
		function selectMany(collectionSelector:Function, resultSelector:Function = null):IEnumerable;
		
		/**
		 * Returns a specified number of contiguous elements from the start of a sequence.
		 * 
		 * @return An IEnumerable that contains the specified number of elements from the start of the input sequence.
		 * 
		 * @param count The number of elements to return.
		 * 
		 * @see takeWhile
		 * @see skip
		 * @see skipWhile
		 */
		function take(count:int):IEnumerable;
		
		/**
		 * Returns elements from a sequence as long as a specified condition is true. The element's index is optionally used in the logic of the predicate function.
		 * 
		 * <p>predicate can be of two prototypes
		 * <ul>
		 *   <li>function(element:*):Boolean</li>
		 *   <li>function(element:*, index:int):Boolean</li>
		 * </ul>
		 * </p>
		 * 
		 * @return An IEnumerable that contains elements from the input sequence that occur before the element at which the test no longer passes.
		 * 
		 * @param predicate A function to test each source element for a condition; the optional second parameter of the function represents the index of the source element.
		 * 
		 * @throws ArgumentError when predicate is null
		 * 
		 * @see take
		 * @see skip
		 * @see skipWhile
		 */
		function takeWhile(predicate:Function):IEnumerable;
		
		/**
		 * Bypasses a specified number of elements in a sequence and then returns the remaining elements.
		 * 
		 * @return n IEnumerable<T> that contains the elements that occur after the specified index in the input sequence.
		 * 
		 * @param count The number of elements to skip before returning the remaining elements.
		 * 
		 * @see takeWhile
		 * @see take
		 * @see skipWhile
		 */
		function skip(count:int):IEnumerable; 
		
		/**
		 * Bypasses elements in a sequence as long as a specified condition is true and then returns the remaining elements. The element's index is optionally used in the logic of the predicate function.
		 * 
		 * <p>predicate can be of two prototypes
		 * <ul>
		 *   <li>function(element:*):Boolean</li>
		 *   <li>function(element:*, index:int):Boolean</li>
		 * </ul>
		 * </p>
		 * 
		 * @return An IEnumerable that contains the elements from the input sequence starting at the first element in the linear series that does not pass the test specified by predicate.
		 * 
		 * @param predicate A function to test each source element for a condition; the optional second parameter of the function represents the index of the source element.
		 * 
		 * @throws ArgumentError when predicate is null
		 * 
		 * @see take
		 * @see takeWhile
		 * @see skip
		 */
		function skipWhile(predicate:Function):IEnumerable;

		/**
		 * Correlates the elements of two sequences based on matching keys. The default equality comparer is used to compare keys.
		 * 
		 * outerKeySelector and innerKeySelector are of the prototype: function(element:*):*
		 * resultSelector is of the prototype: function(inner:*, outer:*):*
		 * 
		 * @return An IEnumerable that has elements of type TResult that are obtained by performing an inner join on two sequences.
		 * 
		 * @param inner The sequence to join to the first sequence.
		 * @param outerKeySelector A function to extract the join key from each element of the first sequence.
		 * @param innerKeySelector A function to extract the join key from each element of the second sequence.
		 * @param resultSelector A function to create a result element from two matching elements.
		 * 
		 * @throws ArgumentError when inner or outerKeySelector or innerKeySelector or resultSelector is null.
		 * 
		 * @see groupJoin
		 */
		function join(inner:IEnumerable, outerKeySelector:Function, innerKeySelector:Function, resultSelector:Function):IEnumerable;
		
		/**
		 * Correlates the elements of two sequences based on equality of keys and groups the results. The default equality comparer is used to compare keys.
		 * 
		 * outerKeySelector and innerKeySelector are of the prototype: function(element:*):*
		 * resultSelector is of the prototype: function(inner:*, inner:IEnumerable):*
		 * 
		 * @return An IEnumerable that contains elements =that are obtained by performing a grouped join on two sequences.
		 * 
		 * @param inner The sequence to join to the first sequence.
		 * @param outerKeySelector A function to extract the join key from each element of the first sequence.
		 * @param innerKeySelector A function to extract the join key from each element of the second sequence.
		 * @param resultSelector A function to create a result element from two matching elements.
		 * 
		 * @throws ArgumentError when inner or outerKeySelector or innerKeySelector or resultSelector is null.
		 * 
		 * @see join
		 */
		function groupJoin(inner:IEnumerable, outerKeySelector:Function, innerKeySelector:Function, resultSelector:Function):IEnumerable;
		
		/**
		 * Sorts the elements of a sequence in ascending order by using an optional comparer.
		 * 
		 * keySelector is of the prototype: function(element:*):*
		 * 
		 * @return An IOrderedEnumerable whose elements are sorted according to a key.
		 * 
		 * @param keySelector A function to extract a key from an element.
		 * @param comparer An IComparer to compare keys.
		 * 
		 * @throws ArgumentError when keySelector is null
		 * 
		 * @see orderByDescending
		 * @see IOrderedEnumerable.thenBy
		 * @see IOrderedEnumerable.thenByDescending
		 */
		function orderBy(keySelector:Function, comparer:IComparer=null):IOrderedEnumerable;
		
		/**
		 * Sorts the elements of a sequence in descending order by using an optional comparer.
		 * 
		 * keySelector is of the prototype: function(element:*):*
		 * 
		 * @return An IOrderedEnumerable whose elements are sorted in descending order according to a key.
		 * 
		 * @param keySelector A function to extract a key from an element.
		 * @param comparer An IComparer to compare keys.
		 * 
		 * @throws ArgumentError when keySelector is null
		 * 
		 * @see orderBy
		 * @see IOrderedEnumerable.thenBy
		 * @see IOrderedEnumerable.thenByDescending
		 */
		function orderByDescending(keySelector:Function, comparer:IComparer=null):IOrderedEnumerable;
		
		/**
		 * Groups the elements of a sequence according to a specified key selector function and creates a result value from each group and its key. 
		 * The elements of each group are projected by using a specified function.
		 * 
		 * keySelector and elementSelector are of the prototype: function(element:*):*
		 * resultSelector is of the prototype: function(key:*, elements:IEnumerable):*
		 * 
		 * @return A collection of elements where each element represents a projection over a group and its key.
		 * 
		 * @param keySelector A function to extract the key for each element.
		 * @param elementSelector A function to map each source element to an element in an IGrouping
		 * @param resultSelector A function to create a result value from each group.
		 * 
		 * @throws ArgumentError when keySelector is null
		 * 
		 * @see toLookup
		 */
		function groupBy(keySelector:Function, elementSelector:Function=null, resultSelector:Function=null):IEnumerable;
	
		/**
		 * Concatenates two sequences.
		 * 
		 * @return An IEnumerable that contains the concatenated elements of the two input sequences.
		 * 
		 * @param second The sequence to concatenate to the first sequence.
		 * 
		 * @throw ArgumentException when second is null
		 */
		function concat(second:IEnumerable):IEnumerable;
		
		/**
		 * Merges two sequences by using the specified predicate function.
		 * 
		 * resultSelector is of the prototype: function(left*:, right:*):*
		 * 
		 * @return An IEnumerable that contains merged elements of two input sequences.
		 * 
		 * @param second The second sequence to merge.
		 * @param resultSelector A function that specifies how to merge the elements from the two sequences.
		 * 
		 * @throw ArgumentException if second or resultSelector is null
		 */
		function zip(second:IEnumerable, resultSelector:Function):IEnumerable;
		
		/**
		 * Returns distinct elements from a sequence, optionally using a specified IEqualityComparer to compare values.
		 * 
		 * @return An IEnumerable that contains distinct elements from the source sequence.
		 * 
		 * @param An IEqualityComparer to compare values.
		 */
		function distinct(comparer:IEqualityComparer=null):IEnumerable;
		
		/**
		 * Produces the set union of two sequences by using an optional IEqualityComparer
		 * 
		 * @return An IEnumerable that contains the elements from both input sequences, excluding duplicates.
		 * 
		 * @param second An IEnumerable whose distinct elements form the second set for the union.
		 * @param comparer The IEqualityComparer to compare values.
		 * 
		 * @throws ArgumentError when second is null
		 */
		function union(second:IEnumerable, comparer:IEqualityComparer=null):IEnumerable;
		
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
		 * @see toVector
		 */
		function toArray():Array;
		
		COMPILE::FLEX
		{
			/**
			 * Creates an ArrayCollection from a IEnumerable
			 * 
			 * @return An ArrayCollection that contains the elements from the input sequence.
			 * 
			 * @see toArray
			 * @see toList
			 * @see toDictionary
			 * @see toVector
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
			 * @see toVector
			 */
			function toList():IList;
		}
		
		/**
		 * Creates a typed Vector from an IEnumerable
		 * 
		 * @return A Vector.<type> that contains the elements from the input sequence
		 * 
		 * @param type The type of the data in the strongly-typed vector
		 * 
		 * @see toArrayCollection
		 * @see toList
		 * @see toArray
		 * @see toDictionary
		 **/
		function toVector(type:Class):*;
		
		/**
		 * Creates a Dictionary from an IEnumerable according to specified key selector and element selector functions.
		 * 
		 * keySelector and elementSelector are of the prototype: function(element:*):*
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
		 * @see toVector
		 */ 
		function toDictionary(keySelector:Function, elementSelector:Function=null):Dictionary;
		
		/**
		 * Creates a Lookup from an IEnumerable according to specified key selector and (optional) element selector functions.
		 * 
		 * keySelector and elementSelector are of the prototype: function(element:*):*
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
		 * @see toDictionary
		 * @see toArrayCollection
		 * @see toVector
		 */
		function toLookup(keySelector:Function, elementSelector:Function=null):ILookup;
		
		/**
		 * Returns the elements of the specified sequence or the none if the sequence is empty.
		 * 
		 * @return None if source is empty; otherwise some IEnumerable
		 * 
		 * @see any
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
		 * @see where
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
		 * @see select
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
		 * predicate is of the prototype: function(element:*):Boolean
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
		 * predicate is of the prototype: function(element:*):Boolean
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
		 * predicate is of the prototype: function(element:*):Boolean
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
		 * predicate is of the prototype: function(element:*):Boolean
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
		
		/**
		 * Returns the only element of a sequence that satisfies an optional condition, and throws an exception if more than one such element exists.
		 * 
		 * <p>single can be called in any of two overloads:
		 * <ul>
		 *   <li>single():*</li>
		 *   <li>single(predicate:Function):*</li>
		 * </ul>
		 * </p>
		 * 
		 * predicate is of the prototype: function(element:*):Boolean
		 * 
		 * @return The single element of the input sequence that satisfies an optional condition.
		 * 
		 * @param predicate A function to test each element for a condition.
		 * 
		 * @throw RangeError if sequence contains zero or more than one item
		 * 
		 * @see first
		 * @see firstOrNone
		 * @see last
		 * @see lastOrNone
		 * @see singleOrNone
		 * @see elementAt
		 * @see elementAtOrNone
		 */
		function single(predicate:Function=null):*;
		
		/**
		 * Returns the only element of a sequence that satisfies an optional condition or none if no such element exists; this method throws an exception if more than one element satisfies the condition.
		 * 
		 * <p>lastOrNone can be called in any of two overloads:
		 * <ul>
		 *   <li>singleOrNone():*</li>
		 *   <li>singleOrNone(predicate:Function):*</li>
		 * </ul>
		 * </p>
		 * 
		 * predicate is of the prototype: function(element:*):Boolean
		 * 
		 * @return The single element of the input sequence that satisfies the condition, or none if no such element is found.
		 * 
		 * @param predicate A function to test each element for a condition.
		 *
		 * @throw RangeError if sequence contains more than one item
		 * 
		 * @see first
		 * @see firstOrNone
		 * @see last
		 * @see lastOrNone
		 * @see single
		 * @see elementAt
		 * @see elementAtOrNone
		 */
		function singleOrNone(predicate:Function=null):Option;
		
		/**
		 * Returns the element at a specified index in a sequence.
		 * 
		 * @return The element at the specified position in the source sequence.
		 * 
		 * @param index The zero-based index of the element to retrieve.
		 * 
		 * @throw RangeError if index is less than 0 or greater than or equal to the number of elements in source.
		 * 
		 * @see first
		 * @see firstOrNone
		 * @see last
		 * @see lastOrNone
		 * @see single
		 * @see singleOrNone
		 * @see elementAt
		 */
		function elementAt(index:int):*;
		
		/**
		 * Returns the element at a specified index in a sequence or none if the index is out of range.
		 * 
		 * @return The single element of the input sequence that satisfies the condition, or none if no such element is found.
		 * 
		 * @param index The zero-based index of the element to retrieve.
		 * 
		 * @see first
		 * @see firstOrNone
		 * @see last
		 * @see lastOrNone
		 * @see single
		 * @see singleOrNone
		 * @see elementAt
		 */
		function elementAtOrNone(index:int):Option;
		
		/**
		 * Determines whether any element of a sequence satisfies a condition.
		 * 
		 * predicate is of the prototype: function(element:*):Boolean
		 * 
		 * @return true if any elements in the source sequence pass the test in the optional predicate; otherwise, false.
		 * 
		 * @param predicate A function to test each element for a condition.
		 * 
		 * @see all
		 */
		function any(predicate:Function=null):Boolean;
		
		/**
		 * Determines whether all elements of a sequence satisfy a condition.
		 * 
		 * predicate is of the prototype: function(element:*):Boolean
		 * 
		 * @return true if every element of the source sequence passes the test in the specified predicate, or if the sequence is empty; otherwise, false.
		 * 
		 * @throw ArgumentError when predicate is null
		 * 
		 * @see any
		 */
		function all(predicate:Function):Boolean;
		
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
		 * predicate is of the prototype: function(element:*):Boolean
		 * 
		 * @return The number of elements in the input sequence.
		 * 
		 * @param predicate A function to test each element for a condition.
		 * 
		 * @see first
		 * @see last
		 * 
		 */ 
		function count(predicate:Function=null):int;
		
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
		 * @see any
		 * @see all
		 */ 
		function contains(value:*, comparer:IEqualityComparer=null):Boolean;
		
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
		 * The accumulate (func) function is of the prototype: function(accumulator:*, element:*):*
		 * resultSelector is of the prototype: function(accumulator:*):*
		 * 
		 * @return The final accumulator value.
		 * 
		 * @param funcOrSeed An accumulator function to be invoked on each element. OR The initial accumulator value.
		 * @param func An accumulator function to be invoked on each element.
		 * @param resultSelector A function to transform the final accumulator value into the result value.
		 * 
		 * @throws RangeError
		 * 
		 * @see sum
		 * @see min
		 * @see max
		 * @see average
		 */
		function aggregate(funcOrSeed:*, func:Function=null, resultSelector:Function=null):*;
		
		/**
		 * Computes the sum of a sequence of values.
		 * 
		 * selector function is of prototype: function(element:*):Number
		 * 
		 * @return The sum of the projected values
		 * 
		 * @param selector A transform function to apply to each element.
		 * 
		 * @throws RangeError
		 * 
		 * @see aggregate
		 * @see average
		 */
		function sum(selector:Function=null):*;
		
		/**
		 * Returns the minimum value in a sequence of values. 
		 * 
		 * selector function is of prototype: function(element:*):Number
		 * 
		 * @return The minimum value in the sequence.
		 * 
		 * @param selector A transform function to apply to each element.
		 * 
		 * @throws RangeError
		 * 
		 * @see aggregate
		 * @see max
		 */
		function min(selector:Function=null):*;
		
		/**
		 * Returns the maximum value in a sequence of values. 
		 * 
		 * selector function is of prototype: function(element:*):Number
		 * 
		 * @return The maximum value in the sequence.
		 * 
		 * @param selector A transform function to apply to each element.
		 * 
		 * @throws RangeError
		 * 
		 * @see aggregate
		 * @see min
		 */
		function max(selector:Function=null):*;
		
		/**
		 * Returns the average value in a sequence of values. 
		 * 
		 * selector function is of prototype: function(element:*):Number
		 * 
		 * @return The average value in the sequence.
		 * 
		 * @param selector A transform function to apply to each element.
		 * 
		 * @throws RangeError
		 * 
		 * @see aggregate
		 * @see sum
		 */
		function average(selector:Function=null):*;
		
		/**
		 * Invokes an action on each value in a sequence
		 * 
		 * action function is of prototype: function(element:*):void
		 * 
		 * @param action The action to execute on each element in a sequence 
		 */
		function eachElement(action:Function):void;
	}
}