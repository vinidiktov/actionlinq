package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	import mx.collections.ArrayCollection;

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
			c.prototype.Distinct = function():IEnumerable {
				return this.AsEnumerable().Distinct();
			}
			c.prototype.ToArray = function():Array {
				return this.AsEnumerable().ToArray();
			}
			c.prototype.ToArrayCollection = function():ArrayCollection {
				return this.AsEnumerable().ToArrayCollection();
			}
			c.prototype.First = function(predicate:Function=null):* {
				return this.AsEnumerable().First(predicate);
			}
			c.prototype.Any = function(predicate:Function=null):Boolean {
				return this.AsEnumerable().Any(predicate);
			}		
			c.prototype.Aggregate = function(seed:*, aggregator:Function):* {
				return this.AsEnumerable().Aggregate(seed, aggregator);
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
				"Skip", "SkipWhile", "OrderBy", "Concat", "Zip", "Distinct",
				"ToArray", "ToArrayCollection", "First", "Any", 
				"Aggregate", "Sum", "Min", "Max", "Average", "Each"];
			
			for each(var name in names)
				Array.prototype.setPropertyIsEnumerable(name, false);
		}
	}
}