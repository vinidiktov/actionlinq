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
			this.enumerator = enumerable.GetEnumerator();
			this.selector = selector;
		}
		
		public function MoveNext():Boolean
		{
			if(enumerator.MoveNext())
			{
				if(selector.length == 1)
					current = selector(enumerator.Current());
				else
					current = selector(enumerator.Current(), ++count);
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