package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	internal class SelectEnumerator implements IEnumerator
	{
		private var enumerator:IEnumerator;
		private var selector:Function;
		private var current:*;
		private var count:int = -1;
		
		public function SelectEnumerator(enumerable:IEnumerable, selector:Function)
		{
			this.enumerator = enumerable.getEnumerator();
			this.selector = selector;
		}
		
		public function MoveNext():Boolean
		{
			if(enumerator.MoveNext())
			{
				current = selector.length == 1 ? selector(enumerator.Current()) : selector(enumerator.Current(), ++count);
				return true;
			}
			
			return false;
		}
		
		public function Current():*
		{
			return current;
		}
		
		public function Reset():void
		{
			enumerator.Reset();
			count = -1;
			current = null;
		}
	}
}