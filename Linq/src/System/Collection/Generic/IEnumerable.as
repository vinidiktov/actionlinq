package System.Collection.Generic
{
	import System.Linq.*;
	
	import mx.collections.ArrayCollection;

	public interface IEnumerable
	{
		function GetEnumerator():IEnumerator; 
		
		function Where(predicate:Function):IEnumerable;		
		//* IEnumerable<TSource> Where<TSource>(Func<TSource, bool> predicate);
		//IEnumerable<TSource> Where<TSource>(Func<TSource, int, bool> predicate);

		function Select(selector:Function):IEnumerable;
		//* IEnumerable<TResult> Select<TSource, TResult>(Func<TSource, TResult> selector);
		//IEnumerable<TResult> Select<TSource, TResult>(Func<TSource, int, TResult> selector);
		
		function SelectMany(collectionSelector:Function, resultSelector:Function):IEnumerable;
		//IEnumerable<TResult> SelectMany<TSource, TResult>(Func<TSource, IEnumerable<TResult>> selector);		
		//IEnumerable<TResult> SelectMany<TSource, TResult>(Func<TSource, int, IEnumerable<TResult>> selector);
		//IEnumerable<TResult> SelectMany<TSource, TCollection, TResult>(Func<TSource, int, IEnumerable<TCollection>> collectionSelector, Func<TSource, TCollection, TResult> resultSelector);
		//* IEnumerable<TResult> SelectMany<TSource, TCollection, TResult>(Func<TSource, IEnumerable<TCollection>> collectionSelector, Func<TSource, TCollection, TResult> resultSelector);

		function Take(count:int):IEnumerable;
		//IEnumerable<TSource> Take<TSource>(int count);
		
		
		function Skip(count:int):IEnumerable; 
		//* public static IEnumerable<TSource> Skip<TSource>(int count);
		
		function Concat(second:IEnumerable):IEnumerable;
		//* public static IEnumerable<TSource> Concat<TSource>(IEnumerable<TSource> second);
		
		function ToArray():Array;
		function ToArrayCollection():ArrayCollection;
		//* public static TSource[] ToArray<TSource>();
		
		
		
		function First(predicate:Function=null):*;
		//* public static TSource First<TSource>();
		//* public static TSource First<TSource>(Func<TSource, bool> predicate);
		
		//public static TSource FirstOrDefault<TSource>();
		//public static TSource FirstOrDefault<TSource>(Func<TSource, bool> predicate);
		
		function Any(predicate:Function=null):Boolean;
		//* public static bool Any<TSource>();
		//* public static bool Any<TSource>(Func<TSource, bool> predicate);
		
		
		function Aggregate(seed:*, aggregator:Function):*;
		//public static TSource Aggregate<TSource>(Func<TSource, TSource, TSource> func);
		//* public static TAccumulate Aggregate<TSource, TAccumulate>(TAccumulate seed, Func<TAccumulate, TSource, TAccumulate> func);
		//public static TResult Aggregate<TSource, TAccumulate, TResult>(TAccumulate seed, Func<TAccumulate, TSource, TAccumulate> func, Func<TAccumulate, TResult> resultSelector);
		
		function Sum(selector:Function=null):*;
		//* public static int Sum();
		//* public static int Sum<TSource>(Func<TSource, int> selector);
		
	}
}