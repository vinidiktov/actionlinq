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