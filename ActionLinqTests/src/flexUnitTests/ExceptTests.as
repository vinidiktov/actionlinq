package flexUnitTests
{
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class ExceptTests extends EnumerableTestsBase
	{		
		[Test]
		public function except_returns_all_of_first_except_those_in_second():void {
			var first:Array = [2.0, 2.1, 2.2, 2.3, 2.4, 2.5 ];
			var second:Array = [ 2.2 ];
			
			var except:Array = first.except(second.asEnumerable()).toArray();
			
			assertThat(except, array(2.0, 2.1, 2.3, 2.4, 2.5));
		}
		
		[Test(expected="ArgumentError")]
		public function except_throws_ArgumentError_if_second_is_null():void {
			var except = [].except(null);
		}
		[Test]
		public function except_with_comparer_returns_the_exception_of_more_complex_types():void {
			var first:Array = [
				new TestModel("brian", 33, 77777), 
				new TestModel("cara", 34, 123454321), 
				new TestModel("maia", 4, 234565432)];
			
			var second:Array = [new TestModel("cara", 34, 123454321) ];
			
			var except:Array = first.except(second.asEnumerable(), new ModelComparator()).toArray();
			
			assertThat(except.length, equalTo(2));
			assertThat(except[0].name, equalTo("brian"));
			assertThat(except[1].name, equalTo("maia"));
		}
		
	}
}