package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	public class ConcatEnumerator implements IEnumerator
	{
		private var first:IEnumerator;
		private var second:IEnumerator;
		private var current:*;
		
		public function ConcatEnumerator(first:IEnumerable, second:IEnumerable)
		{
			this.first = first.GetEnumerator();
			this.second = second.GetEnumerator();
		}
		
		public function MoveNext():Boolean
		{
			while(first.MoveNext())
			{
				current = first.Current();
				return true;
			}
			
			while(second.MoveNext())
			{
				current = second.Current();
				return true;
			}
			
			current = null;
			return false;
		}
		
		public function Current():*
		{
			return current;
		}
		
		public function Reset():void
		{
			first.Reset();
			second.Reset();
		}
	}
}