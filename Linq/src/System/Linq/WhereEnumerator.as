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
				var matched:Boolean = predicate.length == 1 ? 
					predicate(enumerator.Current()) : 
					predicate(enumerator.Current(), ++count);
				
				if(matched)
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