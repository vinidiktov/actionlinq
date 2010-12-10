package System.Collection.Generic
{
	import System.Linq.*;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;

	public interface IEnumerable
	{
		function GetEnumerator():IEnumerator; 
		
		function Where(predicate:Function):IEnumerable;		
		//* IEnumerable<TSource> Where<TSource>(Func<TSource, bool> predicate);
		//* IEnumerable<TSource> Where<TSource>(Func<TSource, int, bool> predicate);

		function Select(selector:Function):IEnumerable;
		//* IEnumerable<TResult> Select<TSource, TResult>(Func<TSource, TResult> selector);
		//* IEnumerable<TResult> Select<TSource, TResult>(Func<TSource, int, TResult> selector);
		
		function SelectMany(selector:Function, resultsSelector:Function = null):IEnumerable;
		//* IEnumerable<TResult> SelectMany<TSource, TResult>(Func<TSource, IEnumerable<TResult>> selector);		
		//* IEnumerable<TResult> SelectMany<TSource, TResult>(Func<TSource, int, IEnumerable<TResult>> selector);
		//* IEnumerable<TResult> SelectMany<TSource, TCollection, TResult>(Func<TSource, int, IEnumerable<TCollection>> collectionSelector, Func<TSource, TCollection, TResult> resultSelector);
		//* IEnumerable<TResult> SelectMany<TSource, TCollection, TResult>(Func<TSource, IEnumerable<TCollection>> collectionSelector, Func<TSource, TCollection, TResult> resultSelector);

		function Take(count:int):IEnumerable;
		//* IEnumerable<TSource> Take<TSource>(int count);
		
		function TakeWhile(predicate:Function):IEnumerable;
		//* IEnumerable<TSource> TakeWhile<TSource>(Func<TSource, bool> predicate);
		//* IEnumerable<TSource> TakeWhile<TSource>(Func<TSource, int, bool> predicate);
		
		function Skip(count:int):IEnumerable; 
		//* IEnumerable<TSource> Skip<TSource>(int count);
		
		function SkipWhile(predicate:Function):IEnumerable;
		//* IEnumerable<TSource> SkipWhile<TSource>(Func<TSource, bool> predicate);
		//* IEnumerable<TSource> SkipWhile<TSource>(Func<TSource, int, bool> predicate);

		// Join
		// GroupJoin
		
		function OrderBy(keySelector:Function):IEnumerable;
		//* IOrderedEnumerable<TSource> OrderBy<TSource, TKey>(Func<TSource, TKey> keySelector);
		//IOrderedEnumerable<TSource> OrderBy<TSource, TKey>(Func<TSource, TKey> keySelector, IComparer<TKey> comparer);
		
		// OrderByDescending
		// ThenBy
		// ThenByDescending
		// GroupBy
		
		function Concat(second:IEnumerable):IEnumerable;
		//* IEnumerable<TSource> Concat<TSource>(IEnumerable<TSource> second);
		
		function Zip(second:IEnumerable, resultSelector:Function):IEnumerable;
		//* IEnumerable<TResult> Zip<TFirst, TSecond, TResult>(IEnumerable<TSecond> second, Func<TFirst, TSecond, TResult> resultSelector);

		function Distinct():IEnumerable;
		//* IEnumerable<TSource> Distinct<TSource>();
		//IEnumerable<TSource> Distinct<TSource>(IEqualityComparer<TSource> comparer);
		
		function Union(second:IEnumerable):IEnumerable;
		//* IEnumerable<TSource> Union<TSource>(IEnumerable<TSource> second)
		//IEnumerable<TSource> Union<TSource>(IEnumerable<TSource> second, IEqualityComparer<TSource> comparer)
		
		// Intersect
		// Except
		// Reverse
		// SequenceEqual
		// AsEnumerable
		
		function ToArray():Array;
		function ToArrayCollection():ArrayCollection;
		//* public static TSource[] ToArray<TSource>();
		
		function ToList():IList;
		//* public static IList<TSource> ToList<TSource>();
		
		// ToDictionary
		// ToLookup
		// DefaultIfEmpty
		// OfType
		// Cast
		
		function First(predicate:Function=null):*;
		//* public static TSource First<TSource>();
		//* public static TSource First<TSource>(Func<TSource, bool> predicate);
		
		//public static TSource FirstOrDefault<TSource>();
		//public static TSource FirstOrDefault<TSource>(Func<TSource, bool> predicate);
		
		// Last
		// LastOrDefault
		// Single
		// SingleOrDefault
		// ElementAt
		// ElementAtOrDefault
		// Range
		// Repeat
		// Empty
		
		function Any(predicate:Function=null):Boolean;
		//* public static bool Any<TSource>();
		//* public static bool Any<TSource>(Func<TSource, bool> predicate);
		
		// All
		
		function Count(predicate:Function=null):int;
		//* public static int Count<TSource>(Func<TSource, bool> predicate);
		//* public static int Count<TSource>();
		
		// LongCount
		// Contains
		
		function Aggregate(seed:*, aggregator:Function):*;
		//public static TSource Aggregate<TSource>(Func<TSource, TSource, TSource> func);
		//* public static TAccumulate Aggregate<TSource, TAccumulate>(TAccumulate seed, Func<TAccumulate, TSource, TAccumulate> func);
		//public static TResult Aggregate<TSource, TAccumulate, TResult>(TAccumulate seed, Func<TAccumulate, TSource, TAccumulate> func, Func<TAccumulate, TResult> resultSelector);
		
		function Sum(selector:Function=null):*;
		//* int Sum<TSource>();
		//* int Sum<TSource, TSource>(Func<TSource, TSource> selector);
		
		function Min(selector:Function=null):*;
		//* TSource Min<TSource>();
		//* TSource Min<TSource, TResult>(Func<TSource, TResult> selector);
		
		function Max(selector:Function=null):*;
		//* TSource Max<TSource>();
		//* TSource Max<TSource, TResult>(Func<TSource, TResult> selector);
		
		function Average(selector:Function=null):*;
		//* TSource Average<TSource>();
		//* TSource Average<TSource, TResult>(Func<TSource, TResult> selector);
		
		function Each(action:Function):void;
	}
}