package flexUnitTests
{
	import net.digitalprimates.fluint.tests.TestMethod;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class ContainsTests extends EnumerableTestsBase
	{		
		[Test]
		public function Contains_returns_true_when_item_is_in_collection() {
			var dataContainsTwo:Boolean = [2,3,4].Contains(2);
			
			assertThat(dataContainsTwo);
		}
		
		[Test]
		public function Contains_returns_false_when_item_is_not_in_collection() {
			var dataContainsTwo:Boolean = [3,4].Contains(2);
			
			assertThat(dataContainsTwo, equalTo(false));
		}
		
		[Test]
		public function Contains_with_comparer_is_true_when_item_in_collection() {
			var data:Array = [
				new TestModel("brian", 33, 1234),
				new TestModel("cara", 34, 2345),
				new TestModel("eli", 0, 3456) ];
			
			var dataContainsCara:Boolean = data.Contains(new TestModel("cara", 34, 2345), new ModelComparator());
			
			assertThat(dataContainsCara);
		}
		
		[Test]
		public function Contains_with_comparer_is_false_when_item_is_not_in_collection() {
			var data:Array = [
				new TestModel("brian", 33, 1234),
				new TestModel("cara", 34, 2345),
				new TestModel("eli", 0, 3456) ];
			
			var dataContainsMaia:Boolean = data.Contains(new TestModel("maia", 3, 4567), new ModelComparator());
			
			assertThat(dataContainsMaia, equalTo(false));
		}
		
		
	}
}