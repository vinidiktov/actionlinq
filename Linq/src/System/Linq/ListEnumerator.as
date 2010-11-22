package System.Linq
{
	import System.Collection.Generic.IEnumerator;
	
	import mx.collections.IList;
	
	public class ListEnumerator implements IEnumerator
	{
		private var list:IList;
		private var index:int;
		
		public function ListEnumerator(list:IList)
		{
			this.list = list;
			Reset();
		}
		
		public function MoveNext():Boolean
		{
			return ++index < list.length;
		}
		
		public function Current():*
		{
			return list.getItemAt(index);
		}
		
		public function Reset():void
		{
			index = -1;
		}
		
		public function get internalCount():int {
			return list.length;
		}
	}
}