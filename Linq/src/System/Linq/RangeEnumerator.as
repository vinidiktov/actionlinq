package System.Linq
{
	import System.Collection.Generic.IEnumerator;
	
	public class RangeEnumerator implements IEnumerator
	{
		private var start:int;
		private var count:int;
		private var index:int;
		
		public function RangeEnumerator(start:int, count:int)
		{
			this.start = start;
			this.count = count;
			Reset();
		}
		
		public function MoveNext():Boolean
		{
			return ++index < count + start;
		}
		
		public function Current():*
		{
			return index;
		}
		
		public function Reset():void
		{
			index = start - 1;
		}
	}
}