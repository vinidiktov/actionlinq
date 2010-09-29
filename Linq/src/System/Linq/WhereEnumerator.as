package System.Linq
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	internal class WhereEnumerator implements IEnumerator
	{
		private var enumerator:IEnumerator;
		private var predicate:Function;
		private var count:int = -1;
		
		public function WhereEnumerator(enumerable:IEnumerable, predicate:Function)
		{
			this.enumerator = enumerable.GetEnumerator();
			this.predicate = predicate;
		}
		
		public function MoveNext():Boolean
		{
			while(enumerator.MoveNext())
			{
				if(predicate(enumerator.Current(), ++count))
					return true;
			}
			
			return false;
		}
		
		public function Current():*
		{
			return enumerator.Current();
		}

		public function Reset():void
		{
			enumerator.Reset();
			count = -1;
		}
	}
}