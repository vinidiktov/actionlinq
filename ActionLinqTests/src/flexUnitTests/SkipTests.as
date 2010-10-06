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
		public function Skip_Will_Skip_The_Number_Specified()
		{
			var skipped:IEnumerable = [1,2,3,4,5].Skip(2);
			var enumerator:IEnumerator = skipped.GetEnumerator();
			
			Assert.assertTrue(enumerator.MoveNext())
			Assert.assertEquals(enumerator.Current(), 3);
			Assert.assertTrue(enumerator.MoveNext())
			Assert.assertEquals(enumerator.Current(), 4);
			Assert.assertTrue(enumerator.MoveNext())
			Assert.assertEquals(enumerator.Current(), 5);
			Assert.assertFalse(enumerator.MoveNext())
		}
		
		[Test]
		public function SkipWhile_With_Predicate_Skips_Until_Predicate_Is_False()
		{
			var result:Array = [1,2,3,1,2,3].SkipWhile(function(x) { return x < 3 }).ToArray();
			
			assertThat(result, array(3,1,2,3));
		}
		
		[Test]
		public function SkipWhile_With_Static_Predicate_And_No_Index_Does_Not_Fail():void {
			var result:Array = [1,2,3,1,2,3].SkipWhile(lessThan3).ToArray();
			
			assertThat(result, array(3,1,2,3));
		}
		
		private function lessThan3(x) { return x < 3 }
		
		[Test]
		public function SkipWhile_With_Index_Passes_The_Index() {
			var result:Array = [1,2,3,1,2,3].SkipWhile(function(x,i) { return i < 3 }).ToArray();
			
			assertThat(result, array(1,2,3));
		}
		
		[Test]
		public function Reset_Skip_Enumerator_Causes_Entire_Reset()
		{
			var skipped:IEnumerable = [1,2,3,4,5].Skip(2);
			var enumerator:IEnumerator = skipped.GetEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			Assert.assertEquals(enumerator.Current(), 3);
		}
		
		
	}
}