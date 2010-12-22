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
	
	public class IntersectEnumerator implements IEnumerator
	{
		private var first:IEnumerator;
		private var second:IEnumerable;
		private var secondCache:Array = null;
		private var comparer:IEqualityComparer = null;
		private var current:* = null;
		private var invert:Boolean;
		
		
		public function IntersectEnumerator(first:IEnumerable, second:IEnumerable, comparer:IEqualityComparer, invert:Boolean=false)
		{
			this.first = first.getEnumerator();
			this.second = second;
			this.comparer = comparer;
			this.invert = invert;
		}
		
		private function populateSecondCache():void {
			if(secondCache != null)
				return;
			
			secondCache = second.toArray();
		}
		
		public function MoveNext():Boolean
		{
			populateSecondCache();
			
			while(first.MoveNext())
			{
				var possibleCurrent:* = first.Current();
				
				var inBoth:Boolean = inSecond(possibleCurrent);
				
				if(invert ? !inBoth : inBoth)
				{
					current = possibleCurrent;
					return true;
				}
			}
			
			return false;
		}
		
		private function inSecond(item:*):Boolean {
			if(comparer == null)
				return secondCache.indexOf(item) >= 0;
			
			for each(var firstItem:* in secondCache)
			  if(comparer.Equals(firstItem, item))
			  	return true;
			
			return false;
		}
		
		public function Current():*
		{
			return current;
		}
		
		public function Reset():void
		{
			first.Reset();
			secondCache = null;
			current = null;
		}
	}
}