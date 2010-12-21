package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class TakeTests extends EnumerableTestsBase
	{		
		[Test]
		public function take_pulls_first_n_items():void {
			var enumerator:IEnumerator = [2,3,4,5].take(2).getEnumerator();
			
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(2));
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(3));
			assertThat(enumerator.MoveNext(), equalTo(false));
		}
		
		[Test]
		public function takeWhile_pulls_until_predicate_fails():void {
			var result = [1, 2, 3, 1, 2, 3].takeWhile(function(x) {return x < 3}).toArray();
			
			assertThat(result, array(1,2));
		}
		
		[Test]
		public function takeWhile_with_indexer_sends_index():void {
			var result = [1, 2, 3, 1, 2, 3].takeWhile(function(x,i) {return i < 3}).toArray();
			
			assertThat(result, array(1,2,3));
		}
		
		[Test]
		public function takewhile_with_static_predicate_and_no_indexer_succeeds():void {
			var result = [1, 2, 3, 1, 2, 3].takeWhile(lessThan3).toArray();
			
			assertThat(result, array(1,2));
		}
		
		private function lessThan3(x) { 
			return x < 3;
		}
		
		[Test]
		public function resetting_take_causes_enumerator_to_go_back_to_beginning():void {
			var enumerator:IEnumerator = [2,3,4,5].take(2).getEnumerator();
			
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			assertThat(enumerator.Current(), equalTo(2));
		}
		
		[Test(expected="ArgumentError")]
		public function takeWhile_throws_ArgumentError_when_predicate_is_null():void {
			var result = [].takeWhile(null);
		}
		
	}
}