package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	import mx.collections.ArrayCollection;

	public class EnumerationExtender
	{
		public static function Initialize():void {
			InitializeClass(Array);
			InitializeClass(XMLList);
		}
		
		public static function InitializeClass(c:Class):void {
			c.prototype.AsEnumerable = function():IEnumerable {
				return Enumerable.From(this);
			};
			c.prototype.GetEnumerator = function():IEnumerator {
				return this.AsEnumerable().GetEnumerator();
			};
			c.prototype.Where = function(predicate:Function):IEnumerable {
				return this.AsEnumerable().Where(predicate);
			};
			c.prototype.Select = function(selector:Function):IEnumerable {
				return this.AsEnumerable().Select(selector);
			};
			c.prototype.SelectMany = function(collectionSelector:Function, resultSelector:Function):IEnumerable {
				return this.AsEnumerable().SelectMany(collectionSelector, resultSelector);
			}
			c.prototype.Skip = function(count:int):IEnumerable {
				return this.AsEnumerable().Skip(count);
			}
			c.prototype.Concat = function(second:IEnumerable):IEnumerable {
				return this.AsEnumerable().Concat(second);
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
			
			var names:Array = ["AsEnumerable", "GetEnumerator", "Where", "Select", "SelectMany", "Skip", "Concat",
				"ToArray", "ToArrayCollection", "First", "Any", "Aggregate", "Sum"];
			
			for each(var name in names)
				Array.prototype.setPropertyIsEnumerable(name, false);
		}
	}
}