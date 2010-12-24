package flexUnitTests
{
	import System.Linq.EnumerationExtender;

	public class EnumerableTestsBase
	{
		[Before]
		public function before():void
		{
			EnumerationExtender.Initialize();
		}
	}
}