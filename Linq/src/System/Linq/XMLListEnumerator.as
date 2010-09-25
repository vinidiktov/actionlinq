package System.Linq
{
	import System.Collection.Generic.IEnumerator;
	
	public class XMLListEnumerator implements IEnumerator
	{
		private var xml:XMLList;
		private var index:int;
		
		public function XMLListEnumerator(xml:XMLList)
		{
			this.xml = xml;
			Reset();
		}
		
		public function MoveNext():Boolean
		{
			return ++index < xml.length();
		}
		
		public function Current():*
		{
			return xml[index];
		}
		
		public function Reset():void
		{
			index = -1;
		}
	}
}