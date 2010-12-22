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
		public function multi_dimensional_collection_gets_flattened_with_selectMany():void {
			
			var result:IEnumerable = [1,4,7].selectMany(
				function(x) { return [2,5,8].asEnumerable() },
				function(x, y) { return x + y });
			
			assertThat(result.toArray(), array(3,6,9,6,9,12,9,12,15));
		}
		
		[Test]
		public function static_collectoin_selector_without_index_ignores_index():void {
			var result:IEnumerable = [1,4,7].selectMany(
				getSecondSet,
				function(x, y) { return x + y });
			
			assertThat(result.toArray(), array(3,6,9,6,9,12,9,12,15));
		}
		
		private function getSecondSet(x:int):IEnumerable {
			return [2,5,8].asEnumerable();
		}
		
		[Test]
		public function when_collectionSelector_is_empty_it_still_works():void
		{
			var dataB:IEnumerable = [2,5,8].asEnumerable();
			
			var result:IEnumerable = [1,4,7].selectMany(
				function(x) { return x%2 ? dataB : Enumerable.from([]) },
				function(x, y) { return x + y });
			
			assertThat(result.toArray(), array(3,6,9,9,12,15));
		}
		
		[Test]
		public function collectionSelector_receives_index_if_function_takes_it():void {
			var result:Array = [1, 2, 3, 4].selectMany(function(x, i) { return [i]}).toArray();
			
			assertThat(result, array(0,1,2,3));
		}
				
		[Test]
		public function when_resultsselector_is_not_given_selector_is_used():void {
			var data:Array = [1,2,3];
			var transposed:Array = data.selectMany(function(i){return [i,i,i]}).toArray();
			
			assertThat(transposed, array(1,1,1,2,2,2,3,3,3));
		}
		
		[Test]
		public function with_ttatic_collection_selector_and_no_results_selector_no_errors():void {
			var data:Array = [1,2,3];
			var transposed:Array = data.selectMany(tripleSize).toArray();
			
			assertThat(transposed, array(1,1,1,2,2,2,3,3,3));
		}
		
		private function tripleSize(i:int):IEnumerable {
			return [i,i,i].asEnumerable();
		}
		
		[Test]
		public function reset_causes_everything_to_back_to_the_beginning():void {
			
			var result:IEnumerable = [1,4,7].selectMany(
				function(x) { return [2,5,8].asEnumerable() },
				function(x, y) { return x + y });
			var enumerator:IEnumerator = result.getEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			assertThat(enumerator.Current(), equalTo(3));
		}
		
		[Test(expected="ArgumentError")]
		public function selectMany_throws_ArgumentError_when_collectionSelector_is_null():void {
			var result = [].selectMany(null);
		}
		
		
	}
}