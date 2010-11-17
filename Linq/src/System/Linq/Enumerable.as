package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import mx.collections.ArrayCollection;
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
		
		public function Distinct():IEnumerable {
			return new Enumerable(this,
				function(source:*):IEnumerator {
					return new DistinctEnumerator(source) });
		}
		
		public function ToArray():Array {
			var result:Array = new Array();
			var enumerator:IEnumerator = GetEnumerator();
			
			while(enumerator.MoveNext())
				result.push(enumerator.Current());
			
			return result;	
		}
		 
		public function ToArrayCollection():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection();
			var enumerator:IEnumerator = GetEnumerator();
			
			while(enumerator.MoveNext())
				result.addItem(enumerator.Current());
			
			return result;	
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