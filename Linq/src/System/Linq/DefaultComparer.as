package System.Linq
{
	import System.Collection.Generic.IComparer;
	
	public class DefaultComparer implements IComparer
	{
		public function compare(x:*, y:*):int
		{
			if(x > y) return 1;
			if(x < y) return -1;
			return 0;
		}
	}
}