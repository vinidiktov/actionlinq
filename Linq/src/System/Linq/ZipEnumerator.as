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
	
	public class ZipEnumerator implements IEnumerator
	{
		private var left:IEnumerator;
		private var right:IEnumerator;
		private var resultSelector:Function;
		private var current:*
		
		public function ZipEnumerator(left:IEnumerable, right:IEnumerable, resultSelector:Function)
		{
			this.left = left.getEnumerator();
			this.right = right.getEnumerator();
			this.resultSelector = resultSelector;
		}
		
		public function MoveNext():Boolean
		{
			if(left.MoveNext() && right.MoveNext())
			{
				current = resultSelector(left.Current(), right.Current());
				return true;
			}
			
			return false;
		}
		
		public function Current():*
		{
			return current;
		}
		
		public function Reset():void
		{
			left.Reset();
			right.Reset();
			current = null;
		}
	}
}