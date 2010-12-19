package System.Linq
{
	import System.Collection.Generic.IEnumerator;
	import System.Collection.Generic.IGrouping;
	import System.Collection.Generic.ILookup;
	
	import flash.utils.Dictionary;
	
	public class Lookup extends Enumerable implements ILookup
	{
		private var dictionary:Dictionary = new Dictionary();
		
		public function Lookup(groupings:Array=null)
		{
			super( dictionary, function(source:*):IEnumerator { return new GroupingEnumerator(source as Dictionary) });
			
			for each(var group:* in groupings) {
				if(!(group is IGrouping))
					throw new ArgumentError("item in groupings does not implement IGrouping");
				
				dictionary[group.key] = group;
			}
		}
		
		public function add(key:*, value:*):void {
			var grouping:Grouping = dictionary[key];
			if(grouping == null)
			{
				grouping = new Grouping(key);
				dictionary[key] = grouping;
			}
			
			grouping.add(value);
		}
		
		public function lookup(key:*):IGrouping {
			return dictionary[key] as IGrouping;
		}
	}
}