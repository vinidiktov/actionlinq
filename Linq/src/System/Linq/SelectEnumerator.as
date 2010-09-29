package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	internal class SelectEnumerator implements IEnumerator
	{
		private var enumerator:IEnumerator;
		private var selector:Function;
		private var count:int = -1;
		
		public function SelectEnumerator(enumerable:IEnumerable, selector:Function)
		{
			this.enumerator = enumerable.GetEnumerator();
			this.selector = selector;
		}
		
		public function MoveNext():Boolean
		{
			count++;
			return enumerator.MoveNext();
		}
		
		public function Current():*
		{
			return selector(enumerator.Current(), count);
		}
		
		public function Reset():void
		{
			enumerator.Reset();
		}
	}
}