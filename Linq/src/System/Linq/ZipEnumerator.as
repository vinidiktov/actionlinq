package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	public class ZipEnumerator implements IEnumerator
	{
		private var left:IEnumerator;
		private var right:IEnumerator;
		private var resultSelector:Function;
		private var current:*
		
		public function ZipEnumerator(left:IEnumerable, right:IEnumerable, resultSelector:Function)
		{
			this.left = left.getEnumerator();
			this.right = right.getEnumerator();
			this.resultSelector = resultSelector;
		}
		
		public function MoveNext():Boolean
		{
			if(left.MoveNext() && right.MoveNext())
			{
				current = resultSelector(left.Current(), right.Current());
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
			left.Reset();
			right.Reset();
			current = null;
		}
	}
}