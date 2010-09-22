package System.Linq
{
	import System.Collection.Generic.IEnumerator;
	
	internal class ArrayEnumerator implements IEnumerator
	{
		private var array:Array;
		private var index:int;
		
		public function ArrayEnumerator(array:Array)
		{
			this.array = array;
			Reset();
		}
		
		public function MoveNext():Boolean
		{
			return ++index < array.length;
		}
		
		public function Current():*
		{
			return array[index];
		}
		
		public function Reset():void
		{
			index = -1;
		}
	}
}