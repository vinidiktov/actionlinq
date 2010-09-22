package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;

	public class SkipEnumerator implements IEnumerator
	{
		private var enumerator:IEnumerator;
		private var skipCount:int;
		private var index = -1;
		
		public function SkipEnumerator(enumerable:IEnumerable, skipCount:int) {
			this.enumerator = enumerable.GetEnumerator();
			this.skipCount = skipCount;
		}
		
		public function MoveNext():Boolean {
			
			while(enumerator.MoveNext())
			{
				if(++index < skipCount)
					continue;
			
				return true;
			}
			
			return false;
		}
		
		public function Current():* {
			return enumerator.Current();
		}
		
		public function Reset():void {
			enumerator.Reset();
			index = -1;
		}
	}
}