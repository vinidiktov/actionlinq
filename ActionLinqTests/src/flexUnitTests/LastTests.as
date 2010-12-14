package flexUnitTests
{
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class LastTests extends EnumerableTestsBase
	{		
		[Test]
		public function Last_returns_the_last_item():void {
			var last:int = [1,2,3,4].Last();
			
			assertThat(last, equalTo(4));
		}
		
		[Test(expected="RangeError")]
		public function Last_throws_range_error_when_sequence_is_empty():void {
			var data:Array = [];
			data.Last();
		}
		
	}
}