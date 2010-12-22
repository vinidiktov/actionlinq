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
	
	public class SelectManyEnumerator implements IEnumerator
	{
		private var enumerator:IEnumerator;
		private var collectionSelector:Function;
		private var resultSelector:Function;
		private var current:*;
		private var count:int = -1;
		
		public function SelectManyEnumerator(enumerable:IEnumerable, selector:Function, resultsSelector:Function = null)
		{
			if(resultsSelector == null)
				resultsSelector = function(x,y){return y};
			
			this.enumerator = enumerable.getEnumerator();
			
			this.collectionSelector = selector;
			this.resultSelector = resultsSelector;
			
			Reset();
		}
		
		//foreach (TSource item in source)
		//	foreach (TCollection subItem in collectionSelector(item))
		//		yield return resultSelector(item, subItem);
		
		private var collectionEnumerator:IEnumerator;
		
		public function MoveNext():Boolean
		{
			if(collectionEnumerator == null)
			{
				while(true)
				{
					if(!enumerator.MoveNext())
						return false;
					
					if(collectionSelector.length == 1)
						collectionEnumerator = collectionSelector(enumerator.Current()).getEnumerator();
					else
						collectionEnumerator = collectionSelector(enumerator.Current(), ++count).getEnumerator();
					
					if(collectionEnumerator.MoveNext())
						break;
				}
			}
			else
			{
				if(!collectionEnumerator.MoveNext())
				{
					collectionEnumerator = null;
					
					if(MoveNext())
					{
						setCurrent();
						return true;
					}
					else
					{
						return false;
					}
				}
			}
			
			setCurrent();
			return true;
		}
		
		private function setCurrent():void {
			current = resultSelector(enumerator.Current(), collectionEnumerator.Current());	
		}
		
		public function Current():*
		{
			return current;
		}
		
		public function Reset():void
		{
			enumerator.Reset();
			collectionEnumerator = null;
			current = null;
			count = -1;
		}
	}
}