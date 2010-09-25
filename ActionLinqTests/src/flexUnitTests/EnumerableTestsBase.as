package flexUnitTests
{
	import System.Linq.EnumerationExtender;

	public class EnumerableTestsBase
	{
		[Before]
		public function Before():void
		{
			EnumerationExtender.Initialize();
		}
	}
}