package flexUnitTests
{
	import System.Linq.FunctionBuilder.element;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class AllTests extends EnumerableTestsBase
	{		
		[Test]
		public function all_is_true_when_all_conditions_are_met():void {
			var allGreaterThanZero:Boolean = [1,2,3,4,5].all(element.isGreaterThan(0)); 
			
			assertThat(allGreaterThanZero);
		}
		
		[Test]
		public function all_is_false_when_one_condition_is_not_met():void {
			var allGreaterThanZero:Boolean = [0,1,2,3,4,5].all(element.isGreaterThan(0)); 
			
			assertThat(allGreaterThanZero, equalTo(false));
		}
		
		[Test(expected="ArgumentError")]
		public function all_throws_Error_when_predicate_is_null():void {
			var allGreaterThanZero:Boolean = [0,1,2,3,4,5].all(null); 
		}
		
		[Test(expected="ArgumentError")]
		public function all_throws_Error_when_predicate_is_null_and_set_is_empty():void {
			var allGreaterThanZero:Boolean = [].all(null); 
		}
	}
}