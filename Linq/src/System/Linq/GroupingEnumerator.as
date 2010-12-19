package System.Linq
{
	import System.Collection.Generic.IEnumerator;
	
	import flash.utils.Dictionary;
	
	public class GroupingEnumerator implements IEnumerator
	{
		private var dictionary:Dictionary;
		private var keys:Array = new Array();
		private var index:int = -1;
		
		public function GroupingEnumerator(dictionary:Dictionary)
		{
			this.dictionary = dictionary;
			for(var itemName in dictionary)
				keys.push(itemName);
		}
		
		public function MoveNext():Boolean
		{
			return ++index < keys.length;
		}
		
		public function Current():*
		{
			return dictionary[keys[index]];
		}
		
		public function Reset():void
		{
			index = -1;
		}
	}
}