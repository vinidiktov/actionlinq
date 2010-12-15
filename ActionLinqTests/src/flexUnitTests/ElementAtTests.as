package flexUnitTests
{
	import System.Linq.Option.Option;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class ElementAtTests extends EnumerableTestsBase
	{		
		[Test]
		public function ElementAt_returns_element_at_index():void {
			var element:int = [2,4,6,8].ElementAt(2);
			
			assertThat(element, equalTo(6));
		}
		
		[Test(expected="RangeError")]
		public function ElementAt_throws_RangeError_if_index_less_than_zero():void {
			var element:int = [2,4,6,8].ElementAt(-1);
		}
		
		[Test(expected="RangeError")]
		public function ElementAt_throws_RangeError_if_index_greater_than_length():void {
			var element:int = [2,4,6,8].ElementAt(4);
		}
		
		
		[Test]
		public function ElementAtOrNone_returns_element_at_index():void {
			var element:Option = [2,4,6,8].ElementAtOrNone(2);
			
			assertThat(element.value, equalTo(6));
		}
		
		[Test]
		public function ElementAt_returns_none_if_index_less_than_zero():void {
			var element:Option = [2,4,6,8].ElementAtOrNone(-1);
			
			assertThat(element.isNone);
		}
		
		[Test]
		public function ElementAt_returns_none_if_index_greater_than_length():void {
			var element:Option = [2,4,6,8].ElementAtOrNone(4);
			
			assertThat(element.isNone);
		}
	}
}