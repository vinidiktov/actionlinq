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
	
	public class TakeEnumerator implements IEnumerator
	{
		private var enumerator:IEnumerator;
		private var predicate:Function;
		private var index = -1;
		private var taking:Boolean = true;
		private var current:*;
		
		public function TakeEnumerator(enumerable:IEnumerable, predicate:Function) {
			this.enumerator = enumerable.getEnumerator();
			this.predicate = predicate;
		}
		
		public function MoveNext():Boolean {
			
			if(taking && enumerator.MoveNext())
			{
				var possibleCurrent = enumerator.Current();
				
				taking = predicate.length == 1 ? predicate(possibleCurrent) : predicate(possibleCurrent, ++index);
				
				if(taking)
					current = possibleCurrent;
			}
			else
				taking = false;
			
			return taking;
		}
		
		public function Current():* {
			return current;
		}

		public function Reset():void
		{
			enumerator.Reset();
			index = -1;
			taking = true;
			current = null;
		}
	}
}