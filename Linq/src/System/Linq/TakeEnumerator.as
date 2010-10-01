package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	public class TakeEnumerator implements IEnumerator
	{
		private var enumerator:IEnumerator;
		private var predicate:Function;
		private var index = -1;
		private var taking:Boolean = true;
		private var current:*;
		
		public function TakeEnumerator(enumerable:IEnumerable, predicate:Function) {
			this.enumerator = enumerable.GetEnumerator();
			this.predicate = predicate;
		}
		
		public function MoveNext():Boolean {
			
			if(taking && enumerator.MoveNext())
			{
				var possibleCurrent = enumerator.Current();
				
				taking = predicate.length == 1 ? predicate(possibleCurrent) : predicate(possibleCurrent, ++index);
				
				if(taking)
					current = possibleCurrent;
			}
			else
				taking = false;
			
			return taking;
		}
		
		public function Current():* {
			return current;
		}

		public function Reset():void
		{
			enumerator.Reset();
			index = -1;
			taking = true;
			current = null;
		}
	}
}