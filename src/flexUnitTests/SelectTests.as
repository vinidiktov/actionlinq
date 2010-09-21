package flexUnitTests
{
	import System.Collection.Generic.*;
	import System.Linq.*;
	
	import flexunit.framework.*;
	
	public class SelectTests
	{
		[Test]
		public function Select_Maps_Values_To_Function()
		{
			var data:Array = [1,2];
			var mapped:IEnumerable = Enumerable.From(data).Select(function(x){return x*2});
			
			var enumerator:IEnumerator = mapped.GetEnumerator();
			
			Assert.assertTrue(enumerator.MoveNext());
			Assert.assertEquals(enumerator.Current(), 2);
			Assert.assertTrue(enumerator.MoveNext());
			Assert.assertEquals(enumerator.Current(), 4);
			Assert.assertFalse(enumerator.MoveNext());
		}		
	}
}