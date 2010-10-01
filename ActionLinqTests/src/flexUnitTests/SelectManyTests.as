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
		public function Static_Collectoin_Selector_Without_Index_Ignores_Index():void {
			var result:IEnumerable = [1,4,7].SelectMany(
				getSecondSet,
				function(x, y) { return x + y });
			
			assertThat(result.ToArray(), array(3,6,9,6,9,12,9,12,15));
		}
		
		private function getSecondSet(x:int):IEnumerable {
			return [2,5,8].AsEnumerable();
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
		public function CollectionSelector_Receives_Index_If_Function_Takes_It():void {
			var result:Array = [1, 2, 3, 4].SelectMany(function(x, i) { return [i]}).ToArray();
			
			assertThat(result, array(0,1,2,3));
		}
				
		[Test]
		public function When_ResultsSelector_Is_Not_Given_Selector_Is_Used():void {
			var data:Array = [1,2,3];
			var transposed:Array = data.SelectMany(function(i){return [i,i,i]}).ToArray();
			
			assertThat(transposed, array(1,1,1,2,2,2,3,3,3));
		}
		
		[Test]
		public function With_Static_Collection_Selector_And_No_Results_Selector_No_Errors():void {
			var data:Array = [1,2,3];
			var transposed:Array = data.SelectMany(tripleSize).ToArray();
			
			assertThat(transposed, array(1,1,1,2,2,2,3,3,3));
		}
		
		private function tripleSize(i:int):IEnumerable {
			return [i,i,i].AsEnumerable();
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