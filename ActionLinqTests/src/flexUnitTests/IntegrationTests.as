package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Linq.Enumerable;
	
	import flexunit.framework.Assert;

	public class IntegrationTests
	{		
		[Test]
		public function Do_A_Bunch_Of_Stuff() {
			var data:Array = [1,2,3,4,5,6];
			var morphed:IEnumerable = Enumerable.From(data)
				.Where(function(x) { return x % 2 } )
				.Select(function(x) { return x * 4 } )
				.Skip(1);
			
			var result:int = morphed.Sum();
			Assert.assertEquals(result, 32);
			
			result = morphed.Sum();
			Assert.assertEquals(result, 32);
			
		}
		
		
	}
}