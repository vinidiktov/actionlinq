package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	public class TakeEnumerator implements IEnumerator
	{
		private var enumerator:IEnumerator;
		private var takeCount:int;
		private var index = -1;
		
		public function TakeEnumerator(enumerable:IEnumerable, takeCount:int) {
			this.enumerator = enumerable.GetEnumerator();
			this.takeCount = takeCount;
		}
		
		public function MoveNext():Boolean {
			
			if(++index > (takeCount - 1))
				return false;
			
			return enumerator.MoveNext();
		}
		
		public function Current():* {
			return enumerator.Current();
		}

		public function Reset():void
		{
			enumerator.Reset();
			index = -1;
		}
	}
}