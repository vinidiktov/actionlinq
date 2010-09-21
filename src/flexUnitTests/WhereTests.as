package flexUnitTests
{
	import System.Collection.Generic.*;
	import System.Linq.*;
	
	import flexunit.framework.*;

	public class WhereTests
	{		
		[Test]
		public function Where_Filters_On_Predicate(): void
		{
			var data:Array = [1, 2, 3, 4, 5];
			var filtered:IEnumerable = Enumerable.From(data).Where(function(x){return x >= 4});
			
			var enumerator:IEnumerator = filtered.GetEnumerator();
			
			Assert.assertEquals(true, enumerator.MoveNext());
			Assert.assertEquals(4, enumerator.Current());
			Assert.assertEquals(true, enumerator.MoveNext());
			Assert.assertEquals(5, enumerator.Current());
			Assert.assertEquals(false, enumerator.MoveNext());
		}
		
		//[Test]
		//public function Where_Filter_Returns_Array()
		//{
		//	var data:Array = [1, 2, 3, 4, 5];
		//	var filtered:Array = Enumerable.From(data).Where(function(x){return x >= 4}).ToArray();
		//	
		//	Assert.assertEquals(filtered.length, 2);
		//	Assert.assertEquals(filtered[0], 4);
		//	Assert.assertEquals(filtered[1], 5);
		//}
	}
}