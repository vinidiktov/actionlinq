package flexUnitTests
{
	import System.Collection.Generic.*;
	import System.Linq.*;
	
	import flexunit.framework.Assert;

	public class FirstTests extends EnumerableTestsBase
	{		
		[Test]
		public function First_With_Predicate_Returns_First_Match()
		{
			var first:int = [1,2,3,4,5].First(function(x){return x >= 4;});
			
			Assert.assertEquals(first, 4);  
		}
		
		[Test]
		public function First_Without_Predicate_Returns_First_Item()
		{
			var first:int = [1,2,3,4,5].First();
			
			Assert.assertEquals(first, 1);
		}

		
		
	}
}