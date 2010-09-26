package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	import System.Linq.Enumerable;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class SelectManyTests extends EnumerableTestsBase
	{		
		[Test]
		public function Multi_Dimensional_Collection_Gets_Flattened_With_SelectMany():void {
			
			var result:IEnumerable = [1,4,7].SelectMany(
				function(x) { return [2,5,8].AsEnumerable() },
				function(x, y) { return x + y });
			
			assertThat(result.ToArray(), array(3,6,9,6,9,12,9,12,15));
		}
		
		[Test]
		public function When_CollectionSelector_Is_Empty_It_Still_Works():void
		{
			var dataB:IEnumerable = [2,5,8].AsEnumerable();
			
			var result:IEnumerable = [1,4,7].SelectMany(
				function(x) { return x%2 ? dataB : Enumerable.From([]) },
				function(x, y) { return x + y });
			
			assertThat(result.ToArray(), array(3,6,9,9,12,15));
		}
		
		[Test]
		public function Reset_Causes_Everything_To_Back_To_The_Beginning():void {
			
			var result:IEnumerable = [1,4,7].SelectMany(
				function(x) { return [2,5,8].AsEnumerable() },
				function(x, y) { return x + y });
			var enumerator:IEnumerator = result.GetEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			assertThat(enumerator.Current(), equalTo(3));
		}
		
		
	}
}