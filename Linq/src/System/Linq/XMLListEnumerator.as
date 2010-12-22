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
		
		public function get internalCount():int {
			return xml.length();
		}
	}
}