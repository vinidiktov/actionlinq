package flexUnitTests
{
	import System.Linq.Enumerable;
	import System.Linq.FunctionBuilder.element;
	import System.Linq.FunctionBuilder.identity;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class FunctionBuilderTests extends EnumerableTestsBase
	{	
		
		[Test]
		public function isGreaterThan_predicate_builder_returns_function_to_check_greater_than():void {
			var filtered = [1,2,3,4,5].where(element.isGreaterThan(3)).toArray();
			
			assertThat(filtered, array(4,5));
		}
		
		[Test]
		public function isGreaterOrEqual_predicate_builder_returns_function_to_check_greater_than_or_equal():void {
			var filtered = [1,2,3,4,5].where(element.isGreaterOrEqual(3)).toArray();
			
			assertThat(filtered, array(3,4,5));
		}
		
		[Test]
		public function isLessThan_predicte_builder_returns_function_to_check_less_than():void {
			var filtered = [1,2,3,4,5].where(element.isLessThan(3)).toArray();
			
			assertThat(filtered, array(1,2));
		}
		
		[Test]
		public function isLessOrEqual_predicte_builder_returns_function_to_check_less_than_or_equal():void {
			var filtered = [1,2,3,4,5].where(element.isLessOrEqual(3)).toArray();
			
			assertThat(filtered, array(1,2,3));
		}
		
		[Test]
		public function isEqualTo_predicate_builder_returns_functon_to_check_equality():void {
			var filtered = [1,2,3,4,5].where(element.isEqualTo(3)).toArray();
			
			assertThat(filtered, array(3));
		}
		
		[Test]
		public function property_selector_generates_selector_function_based_on_element_name():void {
			var selected = [{Name: "brian", age: 33}, {Name: "maia", age: 3}]
							.select(element.age).toArray();
			
			assertThat(selected, array(33, 3));
		}
		
		[Test]
		public function identity_selector_generates_selector_functon_to_return_identity():void {
			var selected = [1,2,3,4,5].select(identity).toArray();
			
			assertThat(selected, array(1,2,3,4,5));
		}
		
		[Test]
		public function selecting_xml_attributes_should_work():void {
			var xml:XML = <root><item id="foo" /></root>;
			
			var first = Enumerable.from(xml.item).select(element.@id).first();
			
			assertThat(first.toString(), equalTo("foo"));
		}
		
	}
}