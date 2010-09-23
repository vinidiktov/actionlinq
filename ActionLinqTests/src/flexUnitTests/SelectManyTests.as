package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	import System.Linq.Enumerable;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class SelectManyTests
	{		
		[Test]
		public function Multi_Dimensional_Collection_Gets_Flattened_With_SelectMany():void {
			var dataA:IEnumerable = Enumerable.From([1,4,7]);
			var dataB:IEnumerable = Enumerable.From([2,5,8]);
			
			var result:IEnumerable = dataA.SelectMany(
				function(x) { return dataB },
				function(x, y) { return x + y });
			
			assertThat(result.ToArray(), array(3,6,9,6,9,12,9,12,15));
		}
		
		[Test]
		public function When_CollectionSelector_Is_Empty_It_Still_Works():void
		{
			var dataA:IEnumerable = Enumerable.From([1,4,7]);
			var dataB:IEnumerable = Enumerable.From([2,5,8]);
			
			var result:IEnumerable = dataA.SelectMany(
				function(x) { return x%2 ? dataB : Enumerable.From([]) },
				function(x, y) { return x + y });
			
			assertThat(result.ToArray(), array(3,6,9,9,12,15));
		}
		
		[Test]
		public function Reset_Causes_Everything_To_Back_To_The_Beginning():void {
			var dataA:IEnumerable = Enumerable.From([1,4,7]);
			var dataB:IEnumerable = Enumerable.From([2,5,8]);
			
			var result:IEnumerable = dataA.SelectMany(
				function(x) { return dataB },
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