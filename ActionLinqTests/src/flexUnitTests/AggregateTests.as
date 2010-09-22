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
		
		[Test]
		public function Sum_Will_Sum_The_Values_Of_A_Collection()
		{
			var data:Array = [1,2,3,4];
			var sum:int = Enumerable.From(data).Sum();
			
			Assert.assertEquals(sum, 10);
		}
		
		[Test]
		public function Sum_With_Selector_Sums_The_Selected_Values()
		{
			var data:Array = ["a", "ab", "abc", "abcd"];
			var sum:int = Enumerable.From(data).Sum(function(item:String) { return item.length });
			
			Assert.assertEquals(sum, 10);
		}
		
	}
}