package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	import System.Linq.Enumerable;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;

	public class SkipTests extends EnumerableTestsBase
	{		
		[Test]
		public function skip_will_skip_the_number_specified()
		{
			var skipped:IEnumerable = [1,2,3,4,5].skip(2);
			var enumerator:IEnumerator = skipped.getEnumerator();
			
			Assert.assertTrue(enumerator.MoveNext())
			Assert.assertEquals(enumerator.Current(), 3);
			Assert.assertTrue(enumerator.MoveNext())
			Assert.assertEquals(enumerator.Current(), 4);
			Assert.assertTrue(enumerator.MoveNext())
			Assert.assertEquals(enumerator.Current(), 5);
			Assert.assertFalse(enumerator.MoveNext())
		}
		
		[Test]
		public function skipwhile_with_predicate_skips_until_predicate_is_false()
		{
			var result:Array = [1,2,3,1,2,3].skipWhile(function(x) { return x < 3 }).toArray();
			
			assertThat(result, array(3,1,2,3));
		}
		
		[Test]
		public function skipWhile_with_static_predicate_and_no_index_does_not_fail():void {
			var result:Array = [1,2,3,1,2,3].skipWhile(lessThan3).toArray();
			
			assertThat(result, array(3,1,2,3));
		}
		
		private function lessThan3(x) { return x < 3 }
		
		[Test]
		public function skipWhile_with_index_passes_the_index() {
			var result:Array = [1,2,3,1,2,3].skipWhile(function(x,i) { return i < 3 }).toArray();
			
			assertThat(result, array(1,2,3));
		}
		
		[Test]
		public function reset_skip_enumerator_causes_entire_reset()
		{
			var skipped:IEnumerable = [1,2,3,4,5].skip(2);
			var enumerator:IEnumerator = skipped.getEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			Assert.assertEquals(enumerator.Current(), 3);
		}
		
		[Test(expected="ArgumentError")]
		public function skipWhile_throws_ArgumentError_when_predicate_is_null():void {
			var result = [].skipWhile(null);	
		}
		
	}
}