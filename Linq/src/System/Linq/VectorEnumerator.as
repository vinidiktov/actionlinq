package System.Linq
{
	import System.Collection.Generic.IEnumerator;
	
	public class VectorEnumerator implements IEnumerator
	{
		private var vector:Object;
		private var index:int;
		
		public function VectorEnumerator(vector:Object)
		{
			this.vector = vector;
			Reset();
		}
		
		public function MoveNext():Boolean
		{
			return ++index < vector.length;
		}
		
		public function Current():*
		{
			return vector[index];
		}
		
		public function Reset():void
		{
			index = -1;
		}
		
		public function get internalCount():int {
			return vector.length;
		}
	}
}