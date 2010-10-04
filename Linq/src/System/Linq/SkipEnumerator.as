package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;

	public class SkipEnumerator implements IEnumerator
	{
		private var enumerator:IEnumerator;
		private var predicate:Function;
		private var skipping:Boolean = true;
		private var current:*;
		private var index = -1;
		
		public function SkipEnumerator(enumerable:IEnumerable, predicate:Function) {
			this.enumerator = enumerable.GetEnumerator();
			this.predicate = predicate;
		}
		
		public function MoveNext():Boolean {
			if(skipping)
				return SkipThem();
			
			if(enumerator.MoveNext())
			{
				current = enumerator.Current();
				return true;
			}
			
			return false;
		}
		
		public function SkipThem() {
			skipping = false;
			while(enumerator.MoveNext()) {
				var possibleCurrent:* = enumerator.Current();
				if(!evaluatePredicate(possibleCurrent)) {
					current = possibleCurrent
					return true;
				}
			}
			return false;
		}
		
		private function evaluatePredicate(possibleCurrent:*):Boolean {
			if(predicate.length == 1)
				return predicate(possibleCurrent);
			return predicate(possibleCurrent, ++index);
		}
		
		public function Current():* {
			return current;
		}
		
		public function Reset():void {
			enumerator.Reset();
			skipping = true;
			current = null;
			index = -1;
		}
	}
}