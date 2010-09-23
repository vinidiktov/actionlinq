package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	public class SelectManyEnumerator implements IEnumerator
	{
		private var enumerator:IEnumerator;
		private var collectionSelector:Function;
		private var resultSelector:Function;
		
		public function SelectManyEnumerator(enumerable:IEnumerable, collectionSelector:Function, resultSelector:Function)
		{
			this.enumerator = enumerable.GetEnumerator();
			this.collectionSelector = collectionSelector;
			this.resultSelector = resultSelector;
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
					
					collectionEnumerator = this.collectionSelector(enumerator.Current()).GetEnumerator();
					
					if(collectionEnumerator.MoveNext())
						break;
				}
			}
			else
			{
				if(!collectionEnumerator.MoveNext())
				{
					collectionEnumerator = null;
					return MoveNext();
				}
			}
			
			return true;
		}
		
		public function Current():*
		{
			return resultSelector(enumerator.Current(), collectionEnumerator.Current());
		}
		
		public function Reset():void
		{
			enumerator.Reset();
			collectionEnumerator = null;
		}
	}
}