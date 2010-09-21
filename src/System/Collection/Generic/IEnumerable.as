package System.Collection.Generic
{
	import System.Linq.*;

	public interface IEnumerable
	{
		function GetEnumerator():IEnumerator;
		
		function Where(predicate:Function):IEnumerable;		
		//public static IEnumerable<TSource> Where<TSource>(Func<TSource, bool> predicate);
		//public static IEnumerable<TSource> Where<TSource>(Func<TSource, int, bool> predicate);

		function Select(selector:Function):IEnumerable;
		//public static IEnumerable<TResult> Select<TSource, TResult>(Func<TSource, TResult> selector);
		//public static IEnumerable<TResult> Select<TSource, TResult>(Func<TSource, int, TResult> selector);
		
		function ToArray():Array;
		//public static TSource[] ToArray<TSource>();
		
		function First(predicate:Function=null):*;
		//public static TSource First<TSource>();
		//public static TSource First<TSource>(Func<TSource, bool> predicate);
		
		//public static TSource FirstOrDefault<TSource>();
		//public static TSource FirstOrDefault<TSource>(Func<TSource, bool> predicate);
		

		//function Aggregate(seed:*, aggregator:Function):*;
		//function Sum(selector:Function):*;
		
		
		
	}
}