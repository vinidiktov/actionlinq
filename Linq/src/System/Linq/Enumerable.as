package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	import System.Collection.Generic.IEqualityComparer;
	import System.Collection.Generic.ILookup;
	import System.Linq.Option.Option;
	import System.Linq.Option.none;
	import System.Linq.Option.some;
	
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.collections.IList;
	
	public class Enumerable extends Proxy implements IEnumerable
	{
		private var source:*;
		private var enumeratorFactory:Function;
		
		public function Enumerable(source:*, enumeratorFactory:Function) {	
			this.source = source;
			this.enumeratorFactory = enumeratorFactory;	
		} 
		
		public static function From(obj:Object) : IEnumerable {
			if(obj is IEnumerable)
				return obj as IEnumerable;
			
			if(obj is Array)
				return new Enumerable( obj as Array,
					function(source:*):IEnumerator { return new ArrayEnumerator(source as Array) });
			
			if(obj is IList)
				return new Enumerable(obj as IList,
					function(source:*):IEnumerator { return new ListEnumerator(obj as IList) });
			
			if(obj is XMLList)
				return new Enumerable(obj as XMLList,
					function(source:*):IEnumerator { return new XMLListEnumerator(obj as XMLList) });
			
			if("length" in obj)
				return new Enumerable(obj as Vector,
					function (source:*):IEnumerator { return new VectorEnumerator(obj) });
			
			return null;
		}
		
		public function GetEnumerator():IEnumerator
		{
			return enumeratorFactory(source);
		}
		
		public function Where(predicate:Function):IEnumerable {
			return new Enumerable(this,
				function(source:*):IEnumerator {
					return new WhereEnumerator(source, predicate) });
		}
		
		public function Select(selector:Function):IEnumerable {
			return new Enumerable(this,
				function(source:*):IEnumerator {
					return new SelectEnumerator(source, selector) });
		}
		
		public function SelectMany(selector:Function, resultsSelector:Function = null):IEnumerable {
			return new Enumerable(this,
				function(source:*):IEnumerator {
					return new SelectManyEnumerator(source, selector, resultsSelector) });
		}
		
		public function Take(count:int):IEnumerable {
			return TakeWhile(function(x:*,i:int){return i < count});
		}
		
		public function TakeWhile(predicate:Function):IEnumerable {
			return new Enumerable(this,
				function(source:*):IEnumerator {
					return new TakeEnumerator(source, predicate) });
		}
		
		public function Skip(count:int):IEnumerable {
			return SkipWhile(function(x:*,i:int){return i < count});
		}
		
		public function SkipWhile(predicate:Function):IEnumerable {
			return new Enumerable(this,
				function(source:*):IEnumerator {
					return new SkipEnumerator(source, predicate) });
		}
		
		public function join(inner:IEnumerable, outerKeySelector:Function, innerKeySelector:Function, resultSelector:Function) {
			if(inner == null) throw new ArgumentError("inner was null");
			if(outerKeySelector == null) throw new ArgumentError("outerKeySelector was null");
			if(innerKeySelector == null) throw new ArgumentError("innerKeySelector was null");
			if(resultSelector == null) throw new ArgumentError("resultSelector was null");
			
			var innerLookup:ILookup = inner.toLookup(innerKeySelector);
			
			return SelectMany(function(outerItem) { return innerLookup.lookup(outerKeySelector(outerItem)) }, resultSelector);
		}
		
		public function OrderBy(keySelector:Function):IEnumerable {
			return new Enumerable(this,
				function(source:*):IEnumerator {
					return new OrderByEnumerator(source, keySelector) });
		}
		
		public function Concat(second:IEnumerable):IEnumerable {
			return new Enumerable(this,
				function(source:*):IEnumerator {
					return new ConcatEnumerator(source, second) });
		}
		
		public function Zip(second:IEnumerable, resultSelector:Function):IEnumerable {
			return new Enumerable(this,
				function(source:*):IEnumerator {
					return new ZipEnumerator(source, second, resultSelector) });
		}
		
		public function Distinct(comparer:IEqualityComparer=null):IEnumerable {
			return new Enumerable(this,
				function(source:*):IEnumerator {
					return new DistinctEnumerator(source, comparer) });
		}
		
		public function Union(second:IEnumerable, comparer:IEqualityComparer=null):IEnumerable {
			return Concat(second).Distinct(comparer);
		}
		
		public function reverse():IEnumerable {
			return Enumerable.From(toArray().reverse());
		}
		
		public function sequenceEqual(second:IEnumerable, comparer:IEqualityComparer=null):Boolean {
			if(second == null)
				throw new ArgumentError("second was null");
			
			var compare:Function = comparer != null ? comparer.Equals : function(f,s) { return f == s };
			
			var firstEnumerator:IEnumerator = GetEnumerator();
			var secondEnumerator:IEnumerator = second.GetEnumerator();
			
			while(firstEnumerator.MoveNext())
			{
				if(!secondEnumerator.MoveNext())
					return false;
				
				if(!compare(firstEnumerator.Current(),secondEnumerator.Current()))
					return false;
			}
			
			return !secondEnumerator.MoveNext();
		}
		
		public function toArray():Array {
			return populateContainer(new Array(), function(al, item) { al.push(item) });
		}
		
		public function toArrayCollection():ArrayCollection {
			return populateContainer(new ArrayCollection(), function(al, item) { al.addItem(item) });	
		}
		
		public function toList():IList {
			return populateContainer(new ArrayList(), function(al, item) { al.addItem(item) });	
		}
		
		private function addLengthToDictionary(dictionary:Dictionary):Dictionary {
			
			dictionary.length = function():uint { 
				var length:uint = 0;
				for(var item:* in dictionary)
					if(item != "length")
						length++;
				return length;
			};
				
			dictionary.setPropertyIsEnumerable("length", false);
			
			return dictionary;
		}
		
		private function identity(x) { return x; }
		
		public function toDictionary(keySelector:Function, elementSelector:Function=null):Dictionary {
			if(keySelector == null)
				throw new ArgumentError("keySelector was null");
			
			if(elementSelector == null)
				elementSelector = identity;
					
			var result:Dictionary = new Dictionary();
			
			for each(var item in this)
			{
				var key:* = keySelector(item);
				
				if(key == null)
					throw new ArgumentError("keySelector for [" + item.toString() + "] returned null");
				
				if(key in result)
					throw new ArgumentError("keySelector for [" + item.toString() + "] returned a duplicate key");
				
				result[key] = elementSelector(item);
			}
			
			return addLengthToDictionary(result);
		}
		
		public function toLookup(keySelector:Function, elementSelector:Function=null):ILookup {
			if(keySelector == null)
				throw new ArgumentError("keySelector was null");
			
			if(elementSelector == null)
				elementSelector = identity;
			
			var result:Lookup = new Lookup();
			
			Each(function(x:*):void { result.add(keySelector(x), elementSelector(x)) });
			
			return result;
		}
		
		private function populateContainer(container:*, add:Function):* {
			var enumerator:IEnumerator = GetEnumerator();
			
			while(enumerator.MoveNext())
				add(container, enumerator.Current());
			
			return container;	
		}
		
		public function noneIfEmpty():Option {
			return Any() ? some(this) : none;
		}
		
		public function ofType(type:Class):IEnumerable {
			return Where(function(x){ return x is type });
		}
		
		public function cast(type:Class):IEnumerable {
			return Select(function(x) { return type(x) });
		}
		
		public function first(predicate:Function=null):* {
			var result:Option = firstOrNone(predicate);
			
			if(result.isNone)
				throw new RangeError("Seqnence contains no elements");
				
			return result.value; 
		}
		
		public function firstOrNone(predicate:Function=null):Option {
			if(predicate == null)
				predicate = function(x) { return true; };
			
			var filteredEnumerator:IEnumerator = Where(predicate).GetEnumerator();
			
			if(!filteredEnumerator.MoveNext())
				return none;
			
			return some(filteredEnumerator.Current()); 
		}
		
		public function Last(predicate:Function=null):* {
			var result:Option = LastOrNone(predicate);
			
			if(result.isNone)
				throw new RangeError("Seqnence contains no elements");
			
			return result.value;
		}
		
		public function LastOrNone(predicate:Function=null):Option {
			if(predicate == null)
				predicate = function(x) { return true; };
			
			return Where(predicate).Aggregate(none, function(acc, x) { return some(x)});
		}
		
		public function Single(predicate:Function=null):* {
			var result:Option = SingleOrNone(predicate);
			
			if(result.isNone)
				throw new RangeError("Sequence does not contain one element");
			
			return result.value;
		}
		
		public function SingleOrNone(predicate:Function=null):Option {
			if(predicate == null)
				predicate = function(x) { return true; };
			
			var enumerator:IEnumerator = Where(predicate).GetEnumerator();
			
			if(!enumerator.MoveNext())
				return none;
			
			var result:Option = some(enumerator.Current());
			
			if(enumerator.MoveNext())
				return none;
			
			return result;
		}
		
		public function ElementAt(index:int):* {
			var result:Option = ElementAtOrNone(index);
			
			if(result.isNone)
				throw new RangeError("Index was out of range");
			
			return result.value;
		}
		
		public function ElementAtOrNone(index:int):Option {
			var count:int = 0;
			return firstOrNone(function(x) {return (count++ == index);});
		}
			
		
		public function Any(predicate:Function=null):Boolean {
			if(predicate == null)
				predicate = function(x) { return true; };
			
			return Where(predicate).GetEnumerator().MoveNext();
		}
		
		public function All(predicate:Function):Boolean {
			if(predicate == null)
				throw new Error("Predicate was null");
			
			var enumerator:IEnumerator = GetEnumerator();
			while(enumerator.MoveNext())
			{
				if(!predicate(enumerator.Current()))
					return false;
			}
					
			return true;
		}
		
		public function Count(predicate:Function=null):int {
			var enumerator:IEnumerator = predicate != null ? Where(predicate).GetEnumerator() : GetEnumerator();
			
			if("internalCount" in enumerator)
				return (enumerator as Object).internalCount;
			
			var count:int = 0;
			
			while(enumerator.MoveNext())
				count++;
			
			return count;
		}
		
		public function Contains(value:*, comparer:IEqualityComparer=null):Boolean {
			if(comparer == null) {
			    var result:Option = firstOrNone(function(x) { return x == value });
			}
			else {
				var result:Option = firstOrNone(function(x) { return comparer.Equals(x, value) });
			}
			
			return result.isSome;
		}
		
		public function Aggregate(funcOrSeed:*, func:Function=null, resultSelector:Function=null):* {
			
			var enumerator:IEnumerator = GetEnumerator();
			
			if(funcOrSeed is Function)
			{
				if(!enumerator.MoveNext())
					throw new RangeError("Sequence contains no elements");
					
				var aggregate = enumerator.Current();
				var aggregator:Function = funcOrSeed as Function;
			}
			else
			{
				var aggregate = funcOrSeed;
				var aggregator = func;
			}
			
			if(resultSelector == null)
				resultSelector = identity;
			
			while(enumerator.MoveNext()) {
				aggregate = aggregator(aggregate, enumerator.Current());
			}
			
			return resultSelector(aggregate);
		}
		
		public function Sum(selector:Function=null):* {
			if(selector == null)
				selector = identity;
			
			return Aggregate(0.0, function(accumulator:*, item:*) { return accumulator + selector(item) });
		}
		
		public function Average(selector:Function=null):* {
			if(selector == null)
				selector = identity;
			
			var count:int = 0;
			var sum:* = Aggregate(0.0, function(accumulator:*, item:*) 
			{
				count++;
				return accumulator + selector(item) 
			});
			
			return sum / count;
		}
		
		private function ExtremeSelector(comparitor:Function, selector:Function=null):* {
			if(selector == null)
				selector = identity;
			
			var extreme = null;
			var enumerator:IEnumerator = GetEnumerator();
			while(enumerator.MoveNext()) {
				var selectedItem = selector(enumerator.Current());
				if(extreme == null || comparitor(selectedItem, extreme))
					extreme = selectedItem;
			}
			
			if(extreme == null)
				throw new RangeError("Sequence contains no elements");
			
			return extreme;
		}
		
		public function Min(selector:Function=null):* {
			return ExtremeSelector(
				function(left:*, right:*):* { return left < right },
				selector);
		}
		
		public function Max(selector:Function=null):* {
			return ExtremeSelector(
				function(left:*, right:*):* { return left > right },
				selector);
		}
		
		public static function Range(start:int, count:int=-1):IEnumerable {
			if(count < 0)
			{
				count = start;
				start = 0;
			}
			
			return new Enumerable(null,
				function(source:*):IEnumerator {
					return new RangeEnumerator(start, count) });
		}
	
		public static function Repeat(element:*, count:int):IEnumerable {
			if(count < 0)
				throw new RangeError("Count was less than zero");
			
			return new Enumerable(null,
				function(source:*):IEnumerator {
					return new RepeatEnumerator(element, count) });
		}
		
		public static function Empty():IEnumerable {
			return From([]);
		}
		
		public static function Times(count:int, action:Function):void {
			Range(count).Each(action);
		}
		
		public function Each(action:Function):void {
			var enumerator:IEnumerator = GetEnumerator();
			while(enumerator.MoveNext())
				action(enumerator.Current());
		}
		
		private var currentEnumerator:IEnumerator;
		
		override flash_proxy function nextNameIndex (index:int):int {
			if(index <= 0)
			{
				currentEnumerator = GetEnumerator();
			}
			
			return currentEnumerator.MoveNext() ? index + 1 : 0;
		}
		
		override flash_proxy function nextValue(index:int):* {
			return currentEnumerator.Current();
		}
	}
}