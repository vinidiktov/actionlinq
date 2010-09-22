package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	import System.Linq.Enumerable;
	
	import flexunit.framework.Assert;

	public class SkipTests
	{		
		[Test]
		public function Skip_Will_Skip_The_Number_Specified()
		{
			var data:Array = [1,2,3,4,5];
			var skipped:IEnumerable = Enumerable.From(data).Skip(2);
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
		public function Reset_Skip_Enumerator_Causes_Entire_Reset()
		{
			var data:Array = [1,2,3,4,5];
			var skipped:IEnumerable = Enumerable.From(data).Skip(2);
			var enumerator:IEnumerator = skipped.GetEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			Assert.assertEquals(enumerator.Current(), 3);
		}
		
		
	}
}