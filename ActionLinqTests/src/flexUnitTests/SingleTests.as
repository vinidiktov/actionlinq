package flexUnitTests
{
	import System.Linq.Option.Option;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class SingleTests extends EnumerableTestsBase
	{
		[Test]
		public function Single_returns_only_item():void {
			var single:int = [3].Single();
			
			assertThat(single, equalTo(3));
		}
		
		[Test(expected="RangeError")]
		public function Single_throws_RangeError_when_empty():void {
			var single:int = [].Single();
		}
		
		[Test(expected="RangeError")]
		public function Single_throws_RangeError_when_more_than_one():void {
			var single:int = [1,2].Single();
		}
		
		[Test]
		public function Single_with_predicate_returns_only_item():void {
			var single:int = [3,4,5].Single(function(x){return x == 4});
			
			assertThat(single, equalTo(4));
		}
		
		[Test(expected="RangeError")]
		public function Single_with_predicate_throws_RangeError_when_empty():void {
			var single:int = [1,2,3].Single(function(x){return x == 4});
		}
		
		[Test(expected="RangeError")]
		public function Single_with_predicate_throws_RangeError_when_more_than_one():void {
			var single:int = [2,3,4,4].Single(function(x){return x == 4});
		}
		
		
		
		[Test]
		public function SingleOrNone_returns_only_item():void {
			var single:Option = [3].SingleOrNone();
			
			assertThat(single.value, equalTo(3));
		}
		
		[Test]
		public function SingleOrNone_returns_none_when_empty():void {
			var single:Option = [].SingleOrNone();
			
			assertThat(single.isNone);
		}
		
		[Test]
		public function SingleOrNone_returns_none_when_more_than_one():void {
			var single:Option = [1,2].SingleOrNone();
			
			assertThat(single.isNone);
		}
		
		[Test]
		public function SingleOrNone_with_predicate_returns_only_item():void {
			var single:Option = [3,4,5].SingleOrNone(function(x){return x == 4});
			
			assertThat(single.value, equalTo(4));
		}
		
		[Test]
		public function SingleOrNone_with_predicate_returns_none_when_empty():void {
			var single:Option = [1,2,3].SingleOrNone(function(x){return x == 4});
			
			assertThat(single.isNone);
		}
		
		[Test]
		public function SingleOrNone_with_predicate_returns_none_when_more_than_one():void {
			var single:Option = [2,3,4,4].SingleOrNone(function(x){return x == 4});
			
			assertThat(single.isNone);
		}
	}
}