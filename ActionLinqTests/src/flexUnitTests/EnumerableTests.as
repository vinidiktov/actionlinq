package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	import System.Linq.Enumerable;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;

	public class EnumerableTests
	{		
		[Test]
		public function EnumerableFrom_Generates_IEnumerable_From_Array()
		{
			var data:Array = [1,2,3];
			var enumerable:IEnumerable = Enumerable.From(data);
			var enumerator:IEnumerator = enumerable.GetEnumerator();
			
			Assert.assertTrue(enumerator.MoveNext());
			Assert.assertEquals(enumerator.Current(), 1);
			Assert.assertTrue(enumerator.MoveNext());
			Assert.assertEquals(enumerator.Current(), 2);
			Assert.assertTrue(enumerator.MoveNext());
			Assert.assertEquals(enumerator.Current(), 3);
			Assert.assertFalse(enumerator.MoveNext());
		}
		
		[Test]
		public function Calling_Reset_Will_Reset_The_Enumerator_From_Array()
		{
			var data:Array = [1,2,3,4];
			var enumerable:IEnumerable = Enumerable.From(data);
			var enumerator:IEnumerator = enumerable.GetEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			Assert.assertEquals(enumerator.Current(), 1);
		}
		
		[Test]
		public function EnumerableFrom_Generates_IEnumerable_From_IList()
		{
			var data:ArrayCollection = new ArrayCollection([1,2,3]);
			
			var enumerable:IEnumerable = Enumerable.From(data);
			var enumerator:IEnumerator = enumerable.GetEnumerator();
			
			Assert.assertTrue(enumerator.MoveNext());
			Assert.assertEquals(enumerator.Current(), 1);
			Assert.assertTrue(enumerator.MoveNext());
			Assert.assertEquals(enumerator.Current(), 2);
			Assert.assertTrue(enumerator.MoveNext());
			Assert.assertEquals(enumerator.Current(), 3);
			Assert.assertFalse(enumerator.MoveNext());
		}
		
		[Test]
		public function Calling_Reset_Will_Reset_The_Enumerator_From_IList()
		{
			var data:ArrayCollection = new ArrayCollection([1,2,3,4]);
			var enumerable:IEnumerable = Enumerable.From(data);
			var enumerator:IEnumerator = enumerable.GetEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			Assert.assertEquals(enumerator.Current(), 1);
		}
		
		[Test]
		public function Calling_Get_Enumerator_Twice_Yields_Two_Different_IEnumerator()
		{
			var data:Array = [1,2,3];
			var enumerable:IEnumerable = Enumerable.From(data);
			var enumerator1:IEnumerator = enumerable.GetEnumerator();
			var enumerator2:IEnumerator = enumerable.GetEnumerator();
			
			Assert.assertTrue( enumerator1 != enumerator2 );
			
			enumerator1.MoveNext();
			
			enumerator2.MoveNext();
			enumerator2.MoveNext();
			
			Assert.assertEquals(enumerator1.Current(), 1);
			Assert.assertEquals(enumerator2.Current(), 2);
		}
		
	}
}