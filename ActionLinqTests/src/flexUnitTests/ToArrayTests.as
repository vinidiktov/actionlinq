package flexUnitTests
{
	import System.Linq.*;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;

	public class ToArrayTests extends EnumerableTestsBase
	{		
		[Test]
		public function ToArray_Converts_IEnumerable_To_Array():void
		{
			var converted:Array = [1,2].ToArray();
			
			Assert.assertEquals(converted.length, 2);
			Assert.assertEquals(converted[0], 1);
			Assert.assertEquals(converted[1], 2);
		}
		
		[Test]
		public function ToArray_On_Where_Returns_Array()
		{
			var filtered:Array = [1,2,3,4,5].Where(function(x){return x >= 4}).ToArray();
			
			Assert.assertEquals(filtered.length, 2);
			Assert.assertEquals(filtered[0], 4);
			Assert.assertEquals(filtered[1], 5);
		}
		
		[Test]
		public function ToArrayCollection_Converts_IEnumerable_To_Array():void{
			var converted:ArrayCollection = [1,2].ToArrayCollection();
			
			Assert.assertEquals(converted.length, 2);
			Assert.assertEquals(converted[0], 1);
			Assert.assertEquals(converted[1], 2);
		}
		
		[Test]
		public function ToList_Converts_IEnumerable_To_List():void {
			var converted:IList = [1,2].ToList();
			
			Assert.assertEquals(converted.length, 2);
			Assert.assertEquals(converted.getItemAt(0), 1);
			Assert.assertEquals(converted.getItemAt(1), 2);
		}
		
	}
}