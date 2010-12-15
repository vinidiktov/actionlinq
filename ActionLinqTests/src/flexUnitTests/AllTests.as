package flexUnitTests
{
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class AllTests extends EnumerableTestsBase
	{		
		[Test]
		public function All_is_true_when_all_conditions_are_met():void {
			var allGreaterThanZero:Boolean = [1,2,3,4,5].All(function(x) { return x > 0; }); 
			
			assertThat(allGreaterThanZero);
		}
		
		[Test]
		public function All_is_false_when_one_condition_is_not_met():void {
			var allGreaterThanZero:Boolean = [0,1,2,3,4,5].All(function(x) { return x > 0; }); 
			
			assertThat(allGreaterThanZero, equalTo(false));
		}
		
		[Test(expected="Error")]
		public function All_throws_Error_when_predicate_is_null():void {
			var allGreaterThanZero:Boolean = [0,1,2,3,4,5].All(null); 
		}
		
		[Test(expected="Error")]
		public function All_throws_Error_when_predicate_is_null_and_set_is_empty():void {
			var allGreaterThanZero:Boolean = [].All(null); 
		}
	}
}