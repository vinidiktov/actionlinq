package flexUnitTests
{
	import System.Linq.Option.*;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class LastTests extends EnumerableTestsBase
	{		
		[Test]
		public function Last_returns_the_last_item():void {
			var last:int = [1,2,3,4].last();
			
			assertThat(last, equalTo(4));
		}
		
		[Test(expected="RangeError")]
		public function Last_throws_range_error_when_sequence_is_empty():void {
			var data:Array = [];
			data.last();
		}
		
		[Test]
		public function Last_returns_the_last_item_matching_a_predicate():void {
			var last:int = [1,2,3,4,5].last(function(x){return x == 4});
			
			assertThat(last, equalTo(4));
		}
		
		[Test(expected="RangeError")]
		public function Last_with_predicate_throws_when_nothing_matches():void{
			var last:int = [1,2,3,4,5].last(function(x){return x==6});
		}
		
		[Test]
		public function LastOrNone_returns_the_last_item():void {
			var last:Option = [1,2,3].lastOrNone();
			assertThat(last.value, equalTo(3));
		}
		
		[Test]
		public function LastOrNone_returns_none_when_sequence_is_empty():void {
			var result = [].lastOrNone();
			assertThat(result.isNone);
		}
		
		[Test]
		public function LastOrNone_returns_the_last_item_matching_a_predicate():void {
			var last:Option = [1,2,3,4,5].lastOrNone(function(x){return x == 4});
			
			assertThat(last.value, equalTo(4));
		}
		
		[Test]
		public function LastOrNone_with_predicate_returns_none_when_nothing_matches():void{
			var result:Option = [1,2,3,4,5].lastOrNone(function(x){return x==6});
			assertThat(result.isNone);
		}
	}
}