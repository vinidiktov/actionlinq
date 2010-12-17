package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;

	public class CastTests extends EnumerableTestsBase
	{		
		[Test]
		public function cast_casts_items_to_new_type():void {
			var ints:Array = ["1", "2", "3"].cast(int).ToArray();
			
			assertThat(ints, array(1,2,3));
			assertThat(ints[0] is int);
			assertThat(ints[1] is int);
			assertThat(ints[2] is int);
		}
		
		[Test(expected="TypeError")]
		public function cast_thows_TypeError_when_cannot_cast():void {
			var castedData = ["1", "2", "3"].cast(TestModel).ToArray();
		}
		
		[Test]
		public function ofType_filters_sequence_based_on_type():void {
			var ints:Array = [1, "2", 3, "4"].ofType(int).ToArray();
			
			assertThat(ints, array(1,3));
		}
		
	}
}