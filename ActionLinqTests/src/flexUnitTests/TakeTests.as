package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class TakeTests extends EnumerableTestsBase
	{		
		[Test]
		public function Take_Pulls_First_N_Items():void {
			var enumerator:IEnumerator = [2,3,4,5].Take(2).GetEnumerator();
			
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(2));
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(3));
			assertThat(enumerator.MoveNext(), equalTo(false));
		}
		
		[Test]
		public function Resetting_Take_Causes_Enumerator_To_Go_Back_To_Beginning():void {
			var enumerator:IEnumerator = [2,3,4,5].Take(2).GetEnumerator();
			
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			assertThat(enumerator.Current(), equalTo(2));
		}
		
	}
}