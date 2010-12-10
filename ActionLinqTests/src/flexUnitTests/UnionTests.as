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
		public function Union_gets_setA_then_setB_if_not_exists() {
			var setA:Array = [0,2,4,5,6,7];
			var setB:Array = [1,3,5,7];
			
			var union:IEnumerable = setA.Union(Enumerable.From(setB));
			
			assertThat(union.ToArray(), array(0,2,4,5,6,7,1,3));
		}
		
		[Test]
		public function Union_with_comparator_uses_comparator() {
			var setA:Array = [
				new TestModel("brian", 33, 123454321), 
				new TestModel("maia", 4, 234565432) ];
			
			var setB:Array = [
				new TestModel("cara", 34, 123454321),
				new TestModel("eli", 0, 345676543) ];
			
			var union:Array = setA.Union(Enumerable.From(setB), new ModelComparator()).ToArray();
			
			assertThat(union.length, equalTo(3));
			assertThat(union[0].name, equalTo("brian"));
			assertThat(union[1].name, equalTo("maia"));
			assertThat(union[2].name, equalTo("eli"));
		}
		
	}
}