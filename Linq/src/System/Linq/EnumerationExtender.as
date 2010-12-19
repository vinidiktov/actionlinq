package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	import System.Collection.Generic.IEqualityComparer;
	import System.Linq.Option.Option;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;

	public class EnumerationExtender
	{
		public static function Initialize():void {
			InitializeClass(Array);
			//InitializeClass(XMLList);
		}
		
		public static function InitializeClass(c:Class):void {
			c.prototype.AsEnumerable = function():IEnumerable {
				return Enumerable.From(this);
			};
			c.prototype.GetEnumerator = function():IEnumerator {
				return Enumerable.From(this).GetEnumerator();
			};
			c.prototype.Where = function(predicate:Function):IEnumerable {
				return this.AsEnumerable().Where(predicate);
			};
			c.prototype.Select = function(selector:Function):IEnumerable {
				return this.AsEnumerable().Select(selector);
			};
			c.prototype.SelectMany = function(function1:Function, function2:Function = null):IEnumerable {
				return this.AsEnumerable().SelectMany(function1, function2);
			}
			c.prototype.Take = function(count:int):IEnumerable {
				return this.AsEnumerable().Take(count);	
			}
			c.prototype.TakeWhile = function(predicate:Function) {
				return this.AsEnumerable().TakeWhile(predicate);
			}
			c.prototype.Skip = function(count:int):IEnumerable {
				return this.AsEnumerable().Skip(count);
			}
			c.prototype.SkipWhile = function(predicate:Function):IEnumerable {
				return this.AsEnumerable().SkipWhile(predicate);
			}
			c.prototype.OrderBy = function(keySelector:Function):IEnumerable {
				return this.AsEnumerable().OrderBy(keySelector);
			}
			c.prototype.Concat = function(second:IEnumerable):IEnumerable {
				return this.AsEnumerable().Concat(second);
			}
			c.prototype.Zip = function(second:IEnumerable, resultSelector:Function):IEnumerable {
				return this.AsEnumerable().Zip(second, resultSelector);
			}
			c.prototype.Distinct = function(comparer:IEqualityComparer=null):IEnumerable {
				return this.AsEnumerable().Distinct(comparer);
			}
			c.prototype.Union = function(second:IEnumerable, comparer:IEqualityComparer=null):IEnumerable {
				return this.AsEnumerable().Union(second, comparer);
			}
			c.prototype.reverseEnumerate = function():IEnumerable {
				return this.AsEnumerable().reverseEnumerate();
			}
			c.prototype.sequenceEqual = function(second:IEnumerable, comparer:IEqualityComparer=null):Boolean {
				return this.AsEnumerable().sequenceEqual(second, comparer);
			}
			c.prototype.toArray = function():Array {
				return this.AsEnumerable().toArray();
			}
			c.prototype.ToArrayCollection = function():ArrayCollection {
				return this.AsEnumerable().ToArrayCollection();
			}
			c.prototype.ToList = function():IList {
				return this.AsEnumerable().ToList();
			}
			c.prototype.toDictionary = function(keySelector:Function, elementSelector:Function=null):Dictionary {
				return this.AsEnumerable().toDictionary(keySelector, elementSelector);
			}
			c.prototype.noneIfEmpty = function():Option {
				return this.AsEnumerable().noneIfEmpty();
			}
			c.prototype.ofType = function(type:Class):IEnumerable {
				return this.AsEnumerable().ofType(type);
			}
			c.prototype.cast = function(type:Class):IEnumerable {
				return this.AsEnumerable().cast(type);
			}
			c.prototype.First = function(predicate:Function=null):* {
				return this.AsEnumerable().First(predicate);
			}
			c.prototype.FirstOrNone = function(predicate:Function=null):Option {
				return this.AsEnumerable().FirstOrNone(predicate);
			}
			c.prototype.Last = function(predicate:Function=null):* {
				return this.AsEnumerable().Last(predicate);
			}
			c.prototype.LastOrNone = function(predicate:Function=null):Option {
				return this.AsEnumerable().LastOrNone(predicate);
			}
			c.prototype.Single = function(predicate:Function=null):* {
				return this.AsEnumerable().Single(predicate);
			}
			c.prototype.SingleOrNone = function(predicate:Function=null):* {
				return this.AsEnumerable().SingleOrNone(predicate);
			}
			c.prototype.ElementAt = function(index:int):* {
				return this.AsEnumerable().ElementAt(index);
			}
			c.prototype.ElementAtOrNone = function(index:int):Option {
				return this.AsEnumerable().ElementAtOrNone(index);
			}
			c.prototype.Any = function(predicate:Function=null):Boolean {
				return this.AsEnumerable().Any(predicate);
			}		
			c.prototype.All = function(predicate:Function):Boolean {
				return this.AsEnumerable().All(predicate);
			}
			c.prototype.Count = function(predicate:Function=null):int {
				return this.AsEnumerable().Count(predicate);
			}
			c.prototype.Contains = function(value:*, comparer:IEqualityComparer=null):Boolean {
				return this.AsEnumerable().Contains(value, comparer);
			}
			c.prototype.Aggregate = function(funcOrSeed:*, func:Function=null, resultSelector:Function=null):* {
				return this.AsEnumerable().Aggregate(funcOrSeed, func, resultSelector);
			}
			c.prototype.Sum =  function(selector:Function=null):* {
				return this.AsEnumerable().Sum(selector);
			}
			c.prototype.Min = function(selector:Function=null):* {
				return this.AsEnumerable().Min(selector);
			}
			c.prototype.Max = function(selector:Function=null):* {
				return this.AsEnumerable().Max(selector);
			}
			c.prototype.Average = function(selector:Function=null):* {
				return this.AsEnumerable().Average(selector);
			}
			c.prototype.Each = function(action:Function):* {
				this.AsEnumerable().Each(action);
			}
				
			var names:Array = [ "AsEnumerable", "GetEnumerator", "Where", 
				"Select", "SelectMany", "Take", "TakeWhile", 
				"Skip", "SkipWhile", "OrderBy", "Concat", "Zip", "Distinct", "Union", "reverseEnumerate", "sequenceEqual",
				"toArray", "ToArrayCollection", "ToList", "toDictionary", "noneIfEmpty", "ofType", "cast", "First", "FirstOrNone", 
				"Last", "LastOrNone", "Single", "SingleOrNone", "ElementAt", "ElementAtOrNone",
				"Any", "All", "Count", "Contains",
				"Aggregate", "Sum", "Min", "Max", "Average", "Each"];
			
			Enumerable.From(names).Each(function(name:String):void { c.prototype.setPropertyIsEnumerable(name, false) });
		}
	}
}