package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class ZipTests extends EnumerableTestsBase
	{		
		[Test]
		public function Zip_Will_Combine_Two_Enumerables():void {
			var first:IEnumerable = [1,2,3].AsEnumerable();
			var second:IEnumerable = ['a','b','c'].AsEnumerable();
			
			var enumerator:IEnumerator = first.Zip(second, function(f,s) { return f + s }).GetEnumerator();
			
			assertThat(enumerator.MoveNext(), equalTo(true))
			assertThat(enumerator.Current(), equalTo("1a"))
			assertThat(enumerator.MoveNext(), equalTo(true))
			assertThat(enumerator.Current(), equalTo("2b"))
			assertThat(enumerator.MoveNext(), equalTo(true))
			assertThat(enumerator.Current(), equalTo("3c"))
			assertThat(enumerator.MoveNext(), equalTo(false))
		}
		
		[Test]
		public function Left_Has_More_Than_Right_Bound_To_Right_Count():void {
			var result:Array = [1,2,3,4,5]
				.Zip(['a', 'b'].AsEnumerable(), function(f,s) { return f + s})
				.toArray();
			
			assertThat(result, array("1a", "2b"));
		}
		
		[Test]
		public function Right_Has_More_Than_Left_Bound_To_Left_Count():void {
			var result:Array = [1,2]
				.Zip(['a', 'b', 'c', 'd', 'e'].AsEnumerable(), function(f,s) { return f + s})
				.toArray();
			
			assertThat(result, array("1a", "2b"));
		}
		
		[Test]
		public function Reset_Zip_Will_Start_From_Scratch():void {
			var first:IEnumerable = [1,2,3].AsEnumerable();
			var second:IEnumerable = ['a','b','c'].AsEnumerable();
			
			var enumerator:IEnumerator = first.Zip(second, function(f,s) { return f + s }).GetEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			assertThat(enumerator.Current(), equalTo("1a"));
		}
		
	}
}