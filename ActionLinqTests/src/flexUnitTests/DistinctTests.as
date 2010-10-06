package flexUnitTests
{
	import System.Collection.Generic.IEnumerator;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class DistinctTests extends EnumerableTestsBase
	{		
		[Test]
		public function Distinct_makes_sure_all_items_are_unique():void {
			var distinct:IEnumerator = [1,1,2,2,3,3].Distinct().GetEnumerator();
			
			assertThat(distinct.MoveNext(), equalTo(true));
			assertThat(distinct.Current(), equalTo(1));
			assertThat(distinct.MoveNext(), equalTo(true));
			assertThat(distinct.Current(), equalTo(2));
			assertThat(distinct.MoveNext(), equalTo(true));
			assertThat(distinct.Current(), equalTo(3));
			assertThat(distinct.MoveNext(), equalTo(false));
		}
		
		[Test]
		public function Reset_Causes_Everything_To_Go_Back():void {
			var distinct:IEnumerator = [1,1,2,2,3,3].Distinct().GetEnumerator();
			
			distinct.MoveNext();
			distinct.MoveNext();
			distinct.Reset();
			distinct.MoveNext();
			
			assertThat(distinct.Current(), equalTo(1));
		}
		
	}
}