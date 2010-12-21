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
		public function Take_Pulls_First_N_Items():void {
			var enumerator:IEnumerator = [2,3,4,5].Take(2).getEnumerator();
			
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(2));
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(3));
			assertThat(enumerator.MoveNext(), equalTo(false));
		}
		
		[Test]
		public function TakeWhile_Pulls_Until_Predicate_Fails():void {
			var result = [1, 2, 3, 1, 2, 3].TakeWhile(function(x) {return x < 3}).toArray();
			
			assertThat(result, array(1,2));
		}
		
		[Test]
		public function TakeWhile_With_Indexer_Sends_Index():void {
			var result = [1, 2, 3, 1, 2, 3].TakeWhile(function(x,i) {return i < 3}).toArray();
			
			assertThat(result, array(1,2,3));
		}
		
		[Test]
		public function TakeWhile_With_Static_Predicate_And_No_Indexer_Succeeds():void {
			var result = [1, 2, 3, 1, 2, 3].TakeWhile(lessThan3).toArray();
			
			assertThat(result, array(1,2));
		}
		
		private function lessThan3(x) { 
			return x < 3;
		}
		
		[Test]
		public function Resetting_Take_Causes_Enumerator_To_Go_Back_To_Beginning():void {
			var enumerator:IEnumerator = [2,3,4,5].Take(2).getEnumerator();
			
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			assertThat(enumerator.Current(), equalTo(2));
		}
		
	}
}