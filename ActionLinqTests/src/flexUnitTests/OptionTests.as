package flexUnitTests
{
	import System.Linq.Option.*;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class OptionTests
	{		
		[Test]
		public function none_is_none(){
			assertThat(none.isNone);
		}
		
		[Test]
		public function none_is_not_some(){
			assertThat(!none.isSome);
		}
		
		[Test(expected="Error")]
		public function none_throws_when_getting_value(){
			none.value;
		}
		
		[Test]
		public function some_is_some(){
			assertThat(some("").isSome);
		}
		
		[Test]
		public function some_is_not_none(){
			assertThat(!some("").isNone);
		}
		
		[Test]
		public function getting_the_value_of_some_returns_the_value(){
			var optionValue = some("hello world");
			assertThat(optionValue.value, equalTo("hello world"));
		}
	}
}