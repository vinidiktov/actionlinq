package flexUnitTests
{
	import flash.sampler.NewObjectSample;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class IntersectTests extends EnumerableTestsBase
	{		
		[Test]
		public function intersect_returns_the_intersection_of_both_sequences():void {
			var first:Array = [1,2,3,4,5,6,7,8];
			var second:Array = [2,4,5,9,10];
			
			var intersection:Array = first.intersect(second.AsEnumerable()).toArray();
			
			assertThat(intersection, array(2,4,5));
			
		}
		
		[Test(expected="ArgumentError")]
		public function intersect_throws_ArgumentError_if_second_is_null():void {
			var intersection = [].intersect(null);
		}
		
		[Test]
		public function intersect_with_comparer_returns_the_intersection_of_more_complex_types():void {
			var first:Array = [
				new TestModel("brian", 33, 123454321), 
				new TestModel("cara", 34, 123454321), 
				new TestModel("maia", 4, 234565432)];
			
			var second:Array = [
				new TestModel("brian", 33, 999999), 
				new TestModel("cara", 34, 123454321), 
				new TestModel("maia", 4, 999999)];
			
			var intersection:Array = first.intersect(second.AsEnumerable(), new ModelComparator()).toArray();
			
			assertThat(intersection.length, equalTo(1));
			assertThat(intersection[0].name, equalTo("cara"));
		}
		
	}
}