package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	public class Enumerable implements IEnumerable
	{
		private var source:*;
		private var enumeratorFactory:Function;
		
		public function Enumerable(source:*, enumeratorFactory:Function) {
			this.source = source;
			this.enumeratorFactory = enumeratorFactory;	
		}
		
		public static function From(obj:Object) : IEnumerable {
			if(obj is Array)
				return new Enumerable( obj as Array,
					function(source:*):IEnumerator { return new ArrayEnumerator(source as Array) });
			
			//if(obj is IList)
			//	return new Enumerable(new ListEnumerator(obj as IList));
			
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
		
		public function ToArray():Array {
			var result:Array = new Array();
			var enumerator:IEnumerator = GetEnumerator();
			
			while(enumerator.MoveNext())
				result.push(enumerator.Current());
			
			return result;	
		}
		
		public function First(predicate:Function=null):* {
			if(predicate == null)
				predicate = function(x) { return true; };
			
			var filteredEnumerator:IEnumerator = Where(predicate).GetEnumerator();
			return filteredEnumerator.MoveNext() ? filteredEnumerator.Current() : null;
		}
		
		public function Aggregate(seed:*, aggregator:Function):* {
			var aggregate = seed;
			var enumerator:IEnumerator = GetEnumerator();
			
			while(enumerator.MoveNext()) {
				aggregate = aggregator(aggregate, enumerator.Current());
			}
			
			return aggregate;
		}
	}
}