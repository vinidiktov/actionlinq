package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	import System.Linq.Enumerable;
	import System.Linq.RangeEnumerator;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class ConcatTests extends EnumerableTestsBase
	{		
		[Test]
		public function concat_concatenates_two_sets():void {
			var data2:IEnumerable = [3,5,6].asEnumerable();
			var combined:IEnumerable = [1,3,4].concatEnumerable(data2);
			
			var enumerator:IEnumerator = combined.getEnumerator();
			
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
		public function reset_will_reset_both_enumerators():void {
			var data2:IEnumerable = [3,5,6].asEnumerable();
			var combined:IEnumerable = [1,3,4].concatEnumerable(data2);
			
			var enumerator:IEnumerator = combined.getEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			assertThat(enumerator.Current(), equalTo(1));
		}
		
		[Test(expected="ArgumentError")]
		public function concat_throws_ArgumentError_when_second_is_null():void {
			var result = Enumerable.empty.concat(null);
		}
		
	}
}