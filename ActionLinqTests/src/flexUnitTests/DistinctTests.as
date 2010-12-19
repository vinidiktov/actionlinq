package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
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
		
		[Test]
		public function Distinct_with_comparator_uses_comparator():void {
			var data:Array = [
				new TestModel("brian", 33, 123454321), 
				new TestModel("cara", 34, 123454321), 
				new TestModel("maia", 4, 234565432)];
			
			var distinct:Array = data.Distinct(new ModelComparator()).toArray();
			
			assertThat(distinct.length, equalTo(2));
			assertThat(distinct[0].name, equalTo("brian"));
			assertThat(distinct[1].name, equalTo("maia"));
		}
		
	}
}