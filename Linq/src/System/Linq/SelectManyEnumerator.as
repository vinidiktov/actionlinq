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
			
			this.enumerator = enumerable.GetEnumerator();
			
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
						collectionEnumerator = collectionSelector(enumerator.Current()).GetEnumerator();
					else
						collectionEnumerator = collectionSelector(enumerator.Current(), ++count).GetEnumerator();
					
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