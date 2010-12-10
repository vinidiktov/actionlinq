package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	import System.Collection.Generic.IEqualityComparer;
	
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
		
		public function ToArray():Array {
			return populateContainer(new Array(), function(al, item) { al.push(item) });
		}
		
		public function ToArrayCollection():ArrayCollection {
			return populateContainer(new ArrayCollection(), function(al, item) { al.addItem(item) });	
		}
		
		public function ToList():IList {
			return populateContainer(new ArrayList(), function(al, item) { al.addItem(item) });	
		}
		
		private function populateContainer(container:*, add:Function):* {
			var enumerator:IEnumerator = GetEnumerator();
			
			while(enumerator.MoveNext())
				add(container, enumerator.Current());
			
			return container;	
		}
		
		public function First(predicate:Function=null):* {
			if(predicate == null)
				predicate = function(x) { return true; };
			
			var filteredEnumerator:IEnumerator = Where(predicate).GetEnumerator();
			return filteredEnumerator.MoveNext() ? filteredEnumerator.Current() : null;
		}
		
		public function Any(predicate:Function=null):Boolean {
			if(predicate == null)
				predicate = function(x) { return true; };
			
			return Where(predicate).GetEnumerator().MoveNext();
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
		
		public function Aggregate(seed:*, aggregator:Function):* {
			var aggregate = seed;
			var enumerator:IEnumerator = GetEnumerator();
			
			while(enumerator.MoveNext()) {
				aggregate = aggregator(aggregate, enumerator.Current());
			}
			
			return aggregate;
		}
		
		public function Sum(selector:Function=null):* {
			if(selector == null)
				selector = function(x) { return x; };
			
			return Aggregate(0.0, function(accumulator:*, item:*) { return accumulator + selector(item) });
		}
		
		public function Average(selector:Function=null):* {
			if(selector == null)
				selector = function(x) { return x; };
			
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
				selector = function(x:*):* { return x; };
			
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