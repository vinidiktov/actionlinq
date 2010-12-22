package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Linq.Enumerable;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class UnionTests extends EnumerableTestsBase
	{		
		[Test]
		public function union_gets_setA_then_setB_if_not_exists() {
			var setA:Array = [0,2,4,5,6,7];
			var setB:Array = [1,3,5,7];
			
			var union:IEnumerable = setA.union(Enumerable.from(setB));
			
			assertThat(union.toArray(), array(0,2,4,5,6,7,1,3));
		}
		
		[Test]
		public function union_with_comparator_uses_comparator() {
			var setA:Array = [
				new TestModel("brian", 33, 123454321), 
				new TestModel("maia", 4, 234565432) ];
			
			var setB:Array = [
				new TestModel("cara", 34, 123454321),
				new TestModel("eli", 0, 345676543) ];
			
			var union:Array = setA.union(Enumerable.from(setB), new ModelComparator()).toArray();
			
			assertThat(union.length, equalTo(3));
			assertThat(union[0].name, equalTo("brian"));
			assertThat(union[1].name, equalTo("maia"));
			assertThat(union[2].name, equalTo("eli"));
		}
		
		[Test(expected="ArgumentError")]
		public function union_throws_ArgumentError_if_second_is_null():void {
			var intersection = Enumerable.empty.union(null);
		}
		
	}
}