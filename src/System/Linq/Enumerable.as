package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	public class Enumerable implements IEnumerable
	{
		private var enumerator:IEnumerator;
		
		public function Enumerable(enumerator:IEnumerator) {
			this.enumerator = enumerator;	
		}
		
		public static function From(obj:Object) : IEnumerable {
			if(obj is Array)
				return new Enumerable(new ArrayEnumerator(obj as Array));
			
			//if(obj is IList)
			//	return new Enumerable(new ListEnumerator(obj as IList));
			
			return null;
		}
		
		public function GetEnumerator():IEnumerator
		{
			return enumerator;
		}
		
		public function Where(predicate:Function):IEnumerable {
			return new Enumerable(new WhereEnumerator(this, predicate));
		}
		
		public function Select(selector:Function):IEnumerable {
			return new Enumerable(new SelectEnumerator(this, selector));
		}
		
		public function ToArray():Array {
			var result:Array = new Array();
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
	}
}