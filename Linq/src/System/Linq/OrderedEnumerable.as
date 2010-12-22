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
	import System.Collection.Generic.IComparer;
	import System.Collection.Generic.IEnumerator;
	import System.Collection.Generic.IOrderedEnumerable;

	public class OrderedEnumerable extends Enumerable implements IOrderedEnumerable
	{
		private static const defaultComparer:IComparer = new DefaultComparer();
		
		private var comparers:Array;
		
		public function OrderedEnumerable(source:*, keySelector:Function, comparers:Array, comparer:IComparer, descending:Boolean=false)
		{
			this.comparers = comparers;
			
			if(comparer == null)
				comparer = defaultComparer;
			
			var comparison = function(x, y) { 
				var result:int = comparer.compare(keySelector(x), keySelector(y));
				if(descending)
					result *= -1;
				
				return result;
			};
			
			comparers.push(comparison);
			
			super(source, function(source:*):IEnumerator { return new OrderByEnumerator(source, comparers, descending) });
		}
		
		public function thenBy(keySelector:Function, comparer:IComparer=null):IOrderedEnumerable {
			if(keySelector == null) throw new ArgumentError("keySelector was null");
			
			return createOrderedEnumerable(keySelector, comparer, false);
		}
		
		public function thenByDescending(keySelector:Function, comparer:IComparer=null):IOrderedEnumerable {
			if(keySelector == null) throw new ArgumentError("keySelector was null");
			
			return createOrderedEnumerable(keySelector, comparer, true);
		}
		
		public function createOrderedEnumerable(keySelector:Function, comparer:IComparer, descending:Boolean):IOrderedEnumerable {
			return new OrderedEnumerable(this, keySelector, comparers, comparer, descending);
		}
	}
}