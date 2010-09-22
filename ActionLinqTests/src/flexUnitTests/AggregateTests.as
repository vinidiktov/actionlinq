package flexUnitTests
{
	import System.Linq.Enumerable;
	
	import flexunit.framework.Assert;

	public class AggregateTests
	{		
		[Test]
		public function Aggregate_Will_Aggregate_All_Items()
		{
			var data:Array = [1,2,3,4];
			var product:int = Enumerable.From(data).Aggregate(1, 
				function(accumulate:int, item:int) { return accumulate * item });
			
			Assert.assertEquals(product, 24);
		}
		
		
	}
}