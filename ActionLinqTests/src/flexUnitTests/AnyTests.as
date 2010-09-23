package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Linq.Enumerable;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class AnyTests
	{		
		[Test]
		public function Populated_Enumerable_Has_Any():void {
			assertThat(Enumerable.From([1]).Any(), equalTo(true));
		}
		
		[Test]
		public function Unpopulated_Enumerable_Does_Not_Have_Any():void {
			assertThat(Enumerable.From([]).Any(), equalTo(false));
		}
		
		[Test]
		public function Any_With_Predicate_Returns_True_When_Matched():void {
			var enumerable:IEnumerable = Enumerable.From([1,2,3]);
			
			assertThat(enumerable.Any(function(x){return x > 2}), equalTo(true));
		}
		
		[Test]
		public function Any_With_Predicate_Returns_False_When_Not_Matched():void {
			var enumerable:IEnumerable = Enumerable.From([1,2]);
			
			assertThat(enumerable.Any(function(x){return x > 2}), equalTo(false));
		}
		
	}
}