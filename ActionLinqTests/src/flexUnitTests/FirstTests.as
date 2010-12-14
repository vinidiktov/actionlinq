package flexUnitTests
{
	import System.Collection.Generic.*;
	import System.Linq.*;
	import System.Linq.Option.Option;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class FirstTests extends EnumerableTestsBase
	{				
		[Test]
		public function First_without_predicate_returns_first_item()
		{
			var result:int = [1,2,3,4,5].First();
			
			Assert.assertEquals(result, 1);
		}

		[Test(expected="RangeError")]
		public function First_throws_range_error_when_sequence_is_empty():void {
			var result = [].First();
		}
		
		[Test]
		public function First_with_predicate_returns_first_match()
		{
			var result:int = [1,2,3,4,5].First(function(x){return x >= 4;});
			
			Assert.assertEquals(result, 4);  
		}
		
		[Test(expected="RangeError")]
		public function First_with_predicate_throws_range_error_when_no_match():void {
			var result = [].First(function(x){return true});
		}
		
		[Test]
		public function FirstOrNone_without_predicate_returns_first_item()
		{
			var result:Option = [1,2,3,4,5].FirstOrNone();
			
			assertThat(result.value, equalTo(1));
		}
		
		[Test]
		public function FirstOrNone_returns_none_when_sequence_is_empty():void {
			var result:Option = [].FirstOrNone();
			assertThat(result.isNone)
		}
		
		[Test]
		public function FirstOrNone_with_predicate_returns_none_when_no_match():void {
			var result:Option = [].FirstOrNone(function(x){return true});
			assertThat(result.isNone)
		}
		
		[Test]
		public function FirstOrNone_with_predicate_returns_first_match()
		{
			var result:Option = [1,2,3,4,5].FirstOrNone(function(x){return x >= 4;});
			
			assertThat(result.value, equalTo(4));
		}
	}
}