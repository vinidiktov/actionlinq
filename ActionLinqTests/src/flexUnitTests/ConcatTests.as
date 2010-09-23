package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	import System.Linq.Enumerable;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class ConcatTests
	{		
		[Test]
		public function Concat_Concatenates_Two_Sets():void {
			var data1:IEnumerable = Enumerable.From([1,3,4]);
			var data2:IEnumerable = Enumerable.From([3,5,6]);
			var combined:IEnumerable = data1.Concat(data2);
			
			var enumerator:IEnumerator = combined.GetEnumerator();
			
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(1));
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(3));
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(4));
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(3));
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(5));
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(6));
			assertThat(enumerator.MoveNext(), equalTo(false));
		}
		
		[Test]
		public function Reset_Will_Reset_Both_Enumerators():void {
			var data1:IEnumerable = Enumerable.From([1,3,4]);
			var data2:IEnumerable = Enumerable.From([3,5,6]);
			var combined:IEnumerable = data1.Concat(data2);
			
			var enumerator:IEnumerator = combined.GetEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			assertThat(enumerator.Current(), equalTo(1));
		}
		
		
	}
}