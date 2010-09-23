package System.Collection.Generic
{
	import System.Linq.*;

	public interface IEnumerable
	{
		function GetEnumerator():IEnumerator; 
		
		function Where(predicate:Function):IEnumerable;		
		//* public static IEnumerable<TSource> Where<TSource>(Func<TSource, bool> predicate);
		//public static IEnumerable<TSource> Where<TSource>(Func<TSource, int, bool> predicate);

		function Select(selector:Function):IEnumerable;
		//* public static IEnumerable<TResult> Select<TSource, TResult>(Func<TSource, TResult> selector);
		//public static IEnumerable<TResult> Select<TSource, TResult>(Func<TSource, int, TResult> selector);
		
		function SelectMany(collectionSelector:Function, resultSelector:Function):IEnumerable;
		//public static IEnumerable<TResult> SelectMany<TSource, TResult>(Func<TSource, IEnumerable<TResult>> selector);		
		//public static IEnumerable<TResult> SelectMany<TSource, TResult>(Func<TSource, int, IEnumerable<TResult>> selector);
		//public static IEnumerable<TResult> SelectMany<TSource, TCollection, TResult>(Func<TSource, int, IEnumerable<TCollection>> collectionSelector, Func<TSource, TCollection, TResult> resultSelector);
		//* public static IEnumerable<TResult> SelectMany<TSource, TCollection, TResult>(Func<TSource, IEnumerable<TCollection>> collectionSelector, Func<TSource, TCollection, TResult> resultSelector);

		
		function Skip(count:int):IEnumerable; 
		//* public static IEnumerable<TSource> Skip<TSource>(int count);
		
		function Concat(second:IEnumerable):IEnumerable;
		//* public static IEnumerable<TSource> Concat<TSource>(IEnumerable<TSource> second);
		
		function ToArray():Array;
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