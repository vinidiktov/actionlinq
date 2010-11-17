package flexUnitTests
{
	import System.Linq.Enumerable;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class AggregateTests extends EnumerableTestsBase
	{		
		[Test]
		public function Aggregate_Will_Aggregate_All_Items()
		{
			var data:Array = [1,2,3,4];
			var product:int = data.Aggregate(1, 
				function(accumulate:int, item:int) { return accumulate * item });
			
			assertThat(product, equalTo(24));
		}
		
		[Test]
		public function Sum_Will_Sum_The_Values_Of_A_Collection()
		{
			var data:Array = [1,2,3,4];
			var sum:int = data.Sum();
			
			assertThat(sum, equalTo(10));
		}
		
		[Test]
		public function Sum_With_Selector_Sums_The_Selected_Values()
		{
			var data:Array = ["a", "ab", "abc", "abcd"];
			var sum:int = data.Sum(function(item:String) { return item.length });
			
			assertThat(sum, equalTo(10));
		}
		
		[Test]
		public function Sum_With_Empty_Collection_Is_Zero()
		{
			assertThat([].Sum(), equalTo(0));
		}
		
		[Test]
		public function Min_Gets_The_Minimum_Value()
		{
			var min:int = [4,6,3,4,5,2,9].Min();
			
			assertThat(min, equalTo(2));
		}
		
		[Test]
		public function Min_With_Selector_Gets_The_Min_Of_The_Selected_Value()
		{
			var min:int = ["abcd", "ab", "abc", "abcde"].Min(function(item:String) { return item.length });
			
			assertThat(min, equalTo(2));
		}
		
		[Test(expected="RangeError")]
		public function Min_With_Empty_Collection_Throws_Exception()
		{
			var min = [].Min();
		}
		
		[Test]
		public function Max_Gets_The_Maximum_Value()
		{
			var max:int = [4,6,3,4,9,2,5].Max();
			
			assertThat(max, equalTo(9));
		}
		
		[Test]
		public function Max_With_Selector_Gets_The_Max_Of_The_Selected_Value()
		{
			var max:int = ["abcd", "ab", "abc", "abcde", "a"].Max(function(item:String) { return item.length });
			
			assertThat(max, equalTo(5));
		}
		
		[Test(expected="RangeError")]
		public function Max_With_Empty_Collection_Throws_Exception()
		{
			var max = [].Max();
		}
		
		[Test]
		public function Average_Gets_The_Average_Value()
		{
			var average:Number = [4,5,6].Average();
			
			assertThat(average, equalTo(5));
		}
		
		[Test]
		public function Average_With_Selector_Gets_Avarage_Of_Selected_Value():void {
			var average:Number = ["a", "ab", "abc", "abcd"]
				.Average(function(item:String):int { return item.length; });
			
			assertThat(average, equalTo(2.5));
		}
		
	}
}