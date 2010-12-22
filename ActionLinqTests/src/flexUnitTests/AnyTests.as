package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Linq.Enumerable;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class AnyTests extends EnumerableTestsBase
	{		
		[Test]
		public function populated_enumerable_has_any():void {
			assertThat([1].any(), equalTo(true));
		}
		
		[Test]
		public function unpopulated_enumerable_does_not_have_any():void {
			assertThat([].any(), equalTo(false));
		}
		
		[Test]
		public function any_with_predicate_returns_true_when_matched():void {
			assertThat([1,2,3].any(function(x){return x > 2}), equalTo(true));
		}
		
		[Test]
		public function any_with_predicate_returns_false_when_not_matched():void {
			assertThat([1,2].any(function(x){return x > 2}), equalTo(false));
		}
	}
}