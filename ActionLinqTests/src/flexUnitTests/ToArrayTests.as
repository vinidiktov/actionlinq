package flexUnitTests
{
	import System.Linq.*;
	import flexunit.framework.Assert;

	public class ToArrayTests
	{		
		[Test]
		public function ToArray_Converts_IEnumerable_To_Array():void
		{
			var data:Array = [1,2];
			var converted:Array = Enumerable.From(data).ToArray();
			
			Assert.assertEquals(converted.length, 2);
			Assert.assertEquals(converted[0], 1);
			Assert.assertEquals(converted[1], 2);
		}
		
		[Test]
		public function ToArray_On_Where_Returns_Array()
		{
			var data:Array = [1, 2, 3, 4, 5];
			var filtered:Array = Enumerable.From(data).Where(function(x){return x >= 4}).ToArray();
			
			Assert.assertEquals(filtered.length, 2);
			Assert.assertEquals(filtered[0], 4);
			Assert.assertEquals(filtered[1], 5);
		}
		
	}
}