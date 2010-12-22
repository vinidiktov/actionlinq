//Copyright 2010 SRT Solutions
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//	You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//	See the License for the specific language governing permissions and
//limitations under the License.

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