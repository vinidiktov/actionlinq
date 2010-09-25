package flexUnitTests
{
	import System.Collection.Generic.*;
	import System.Linq.*;
	
	import flexunit.framework.*;
	
	import mx.collections.ArrayCollection;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;

	public class WhereTests extends EnumerableTestsBase
	{	
		[Test]
		public function Where_Filters_On_Predicate(): void
		{
			var data:Array = [1, 2, 3, 4, 5];
			var filtered:IEnumerable = data.Where(function(x){return x >= 4});
			var enumerator:IEnumerator = filtered.GetEnumerator();
			
			Assert.assertEquals(true, enumerator.MoveNext());
			Assert.assertEquals(4, enumerator.Current());
			Assert.assertEquals(true, enumerator.MoveNext());
			Assert.assertEquals(5, enumerator.Current());
			Assert.assertEquals(false, enumerator.MoveNext());
		}
		
		[Test]
		public function Resetting_Where_Starts_Over()
		{
			var data:Array = [1, 2, 3, 4, 5];
			var filtered:IEnumerable = data.Where(function(x){return x >= 4});
			var enumerator:IEnumerator = filtered.GetEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			Assert.assertEquals(4, enumerator.Current());
		}
		
	}
}