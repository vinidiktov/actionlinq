package System.Collection.Generic
{
	import System.Linq.*;
	import System.Linq.Option.Option;
	
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
		function Zip(second:IEnumerable, resultSelector:Function):IEnumerable;
		function Distinct(comparer:IEqualityComparer=null):IEnumerable;
		function Union(second:IEnumerable, comparer:IEqualityComparer=null):IEnumerable;
		
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
		function FirstOrNone(predicate:Function=null):Option;
		function Last(predicate:Function=null):*;
		function LastOrNone(predicate:Function=null):Option;
		function Single(predicate:Function=null):*;
		function SingleOrNone(predicate:Function=null):Option;
		function ElementAt(index:int):*;
		function ElementAtOrNone(index:int):Option;
		function Any(predicate:Function=null):Boolean;
		function All(predicate:Function):Boolean;
		function Count(predicate:Function=null):int;
		function Contains(value:*, comparer:IEqualityComparer=null):Boolean;
		function Aggregate(seed:*, aggregator:Function):*;
		//public static TSource Aggregate<TSource>(Func<TSource, TSource, TSource> func);
		//* public static TAccumulate Aggregate<TSource, TAccumulate>(TAccumulate seed, Func<TAccumulate, TSource, TAccumulate> func);
		//public static TResult Aggregate<TSource, TAccumulate, TResult>(TAccumulate seed, Func<TAccumulate, TSource, TAccumulate> func, Func<TAccumulate, TResult> resultSelector);
		
		function Sum(selector:Function=null):*;
		function Min(selector:Function=null):*;
		function Max(selector:Function=null):*;
		function Average(selector:Function=null):*;
		function Each(action:Function):void;
	}
}