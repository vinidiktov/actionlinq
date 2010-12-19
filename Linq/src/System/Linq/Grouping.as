package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	import System.Collection.Generic.IEqualityComparer;
	import System.Collection.Generic.IGrouping;
	import System.Linq.Option.Option;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	public class Grouping extends Enumerable implements IGrouping
	{
		private var _data:Array;
		private var _key:*;
		
		public function Grouping(key:*, data:Array=null)
		{
			_data = data != null ? data : [];
			super(_data, function(source:*):IEnumerator { return new ArrayEnumerator(source as Array) });
			
			if(key == null)
				throw new ArgumentError("key was null");
			
			_key = key;
		}
		
		public function get key():*
		{
			return _key;
		}
		
		public function add(item:*):void {
			_data.push(item);
		}
	}
}