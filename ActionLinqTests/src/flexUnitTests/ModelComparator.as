package flexUnitTests
{
	import System.Collection.Generic.IEqualityComparer;
	
	public class ModelComparator implements IEqualityComparer
	{
		public function Equals(x:*, y:*):Boolean
		{
			return x.soc == y.soc;
		}
	}
}