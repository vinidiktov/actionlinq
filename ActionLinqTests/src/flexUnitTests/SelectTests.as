package flexUnitTests
{
	import System.Collection.Generic.*;
	import System.Linq.*;
	
	import flexunit.framework.*;
	
	public class SelectTests extends EnumerableTestsBase
	{
		[Test]
		public function Select_Maps_Values_To_Function()
		{
			var mapped:IEnumerable = [1,2].Select(function(x){return x*2});
			
			var enumerator:IEnumerator = mapped.GetEnumerator();
			
			Assert.assertTrue(enumerator.MoveNext());
			Assert.assertEquals(enumerator.Current(), 2);
			Assert.assertTrue(enumerator.MoveNext());
			Assert.assertEquals(enumerator.Current(), 4);
			Assert.assertFalse(enumerator.MoveNext());
		}	
		
		[Test]
		public function Resetting_Select_Starts_Over()
		{
			var mapped:IEnumerable = [1,2].Select(function(x){return x*2});
			var enumerator:IEnumerator = mapped.GetEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			Assert.assertEquals(2, enumerator.Current());
		}
	}
}