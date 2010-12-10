package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Linq.Enumerable;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;

	public class UnionTests extends EnumerableTestsBase
	{		
		[Test]
		public function Union_gets_setA_then_setB_if_not_exists() {
			var setA:Array = [0,2,4,5,6,7];
			var setB:Array = [1,3,5,7];
			
			var union:IEnumerable = setA.Union(Enumerable.From(setB));
			
			assertThat(union.ToArray(), array(0,2,4,5,6,7,1,3));
		}
		
	}
}