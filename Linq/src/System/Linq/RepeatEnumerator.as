package System.Linq
{
	import System.Collection.Generic.IEnumerator;
	
	public class RepeatEnumerator implements IEnumerator
	{
		private var element:*;
		private var count:int;
		private var index:int;
		
		public function RepeatEnumerator(element:*, count:int)
		{
			this.element = element;
			this.count = count;
			Reset();
		}
		
		public function MoveNext():Boolean
		{
			return ++index < count;
		}
		
		public function Current():*
		{
			return element;
		}
		
		public function Reset():void
		{
			index = -1;
		}
	}
}