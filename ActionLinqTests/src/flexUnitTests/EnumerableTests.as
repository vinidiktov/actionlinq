package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	import System.Linq.Enumerable;
	import System.Linq.Option.Option;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class EnumerableTests extends EnumerableTestsBase
	{		
		[Test]
		public function EnumerableFrom_Generates_IEnumerable_From_Array()
		{
			var enumerator:IEnumerator = [1,2,3].GetEnumerator();
			
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
			var enumerator:IEnumerator = [1,2,3,4].GetEnumerator();
			
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
		public function EnumerableFrom_Generates_IEnumerable_From_Vector()
		{
			var data:Vector.<int> = Vector.<int>([1,2,3]);
			
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
		public function Calling_Reset_Will_Reset_The_Enumerator_From_Vector()
		{
			var data:Vector.<int> = Vector.<int>([1,2,3]);
			var enumerable:IEnumerable = Enumerable.From(data);
			var enumerator:IEnumerator = enumerable.GetEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			Assert.assertEquals(enumerator.Current(), 1);
		}
		
		//[Test]
		public function EnumerableFrom_Generates_IEnumerable_From_XMLList()
		{
			var data:XML = <data>
				             <item>1</item>
             				 <item>2</item>
             				 <item>3</item>
				           </data>;
			var enumerator:IEnumerator = Enumerable.From(data.item).GetEnumerator();
			
			Assert.assertTrue(enumerator.MoveNext());
			Assert.assertEquals(enumerator.Current(), 1);
			Assert.assertTrue(enumerator.MoveNext());
			Assert.assertEquals(enumerator.Current(), 2);
			Assert.assertTrue(enumerator.MoveNext());
			Assert.assertEquals(enumerator.Current(), 3);
			Assert.assertFalse(enumerator.MoveNext());
		}
		
		//[Test]
		public function Calling_Reset_Will_Reset_The_Enumerator_From_XMLList()
		{
			var data:XML = <data>
							<item>1</item>
							<item>2</item>
							<item>3</item>
						   </data>;
			var enumerator:IEnumerator = Enumerable.From(data.item).GetEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			Assert.assertEquals(enumerator.Current(), 1);
		}
		
		[Test]
		public function Calling_Get_Enumerator_Twice_Yields_Two_Different_IEnumerator()
		{
			var enumerable:IEnumerable = [1,2,3].AsEnumerable();
			var enumerator1:IEnumerator = enumerable.GetEnumerator();
			var enumerator2:IEnumerator = enumerable.GetEnumerator();
			
			Assert.assertTrue( enumerator1 != enumerator2 );
			
			enumerator1.MoveNext();
			
			enumerator2.MoveNext();
			enumerator2.MoveNext();
			
			Assert.assertEquals(enumerator1.Current(), 1);
			Assert.assertEquals(enumerator2.Current(), 2);
		}
		
		//[Test]
		public function Explicit_Cast_Creates_Enumerable():void {
			var data:Array = [1,2,3];
			var enumerable:IEnumerable = Enumerable(data);
			
			assertThat(enumerable.Sum(), equalTo(6));
		}
		
		[Test]
		public function Enumerable_Plays_Nicely_With_for_each():void {
			
			var count = 0;
			for each(var item in [1,2,3].AsEnumerable())
			{
				count += item;
			}
		
			assertThat(count, equalTo(6));
		}
		
		[Test]
		public function EnumerableFrom_Returns_Enumerable_If_Already_Enumerable() {
			var enumerator:IEnumerator = [1,2,3].GetEnumerator();
			
			Assert.assertTrue(enumerator.MoveNext());
			Assert.assertEquals(enumerator.Current(), 1);
			Assert.assertTrue(enumerator.MoveNext());
			Assert.assertEquals(enumerator.Current(), 2);
			Assert.assertTrue(enumerator.MoveNext());
			Assert.assertEquals(enumerator.Current(), 3);
			Assert.assertFalse(enumerator.MoveNext());
		}
		
		[Test]
		public function EnumerableRange_Returns_Enumerable_From_Inputs() {
			var range:IEnumerable = Enumerable.Range(0, 5);
			
			assertThat(range.ToArray(), array(0, 1, 2, 3, 4));
		}
		
		[Test]
		public function EnumerableRange_With_Non_Zero_Start_Returns_Enumerable_From_Inputs() {
			var range:IEnumerable = Enumerable.Range(5, 5);
			
			assertThat(range.ToArray(), array(5, 6, 7, 8, 9));
		}
		
		[Test]
		public function EnumerableRange_With_One_Parameter_Assumes_Zero_Start() {
			var range:IEnumerable = Enumerable.Range(5);
			
			assertThat(range.ToArray(), array(0, 1, 2, 3, 4));
		}
		
		[Test]
		public function EnumerableRepeat_with_item_repeats_n_times() {
			var repeat:IEnumerable = Enumerable.Repeat("test", 3);
			
			assertThat(repeat.ToArray(), array("test", "test", "test"));
		}
		
		[Test(expected="RangeError")]
		public function EnumerableRepeat_throws_RangeError_if_count_less_than_zero():void {
			var repeat:IEnumerable = Enumerable.Repeat("test", -1);
		}
		
		[Test]
		public function EnumerableEmpty_returns_empty_enumerable():void {
			var empty:IEnumerable = Enumerable.Empty();
			
			assertThat(empty.ToArray(), array());
		}
		
		[Test]
		public function Each_Runs_An_Action_On_Each():void {
			var count:int = 0;
			var set:Array = [1, 2, 3, 4];
			set.Each(function(){count++});
			
			assertThat(count, equalTo(4));
		}
		
		[Test]
		public function Each_Runs_An_Action_On_Each_With_Parameter():void {
			var count:int = 0;
			var set:Array = [1, 2, 3, 4];
			set.Each(function(x){count+= x});
			
			assertThat(count, equalTo(10));
		}
		
		[Test]
		public function Times_Does_Something_N_Times():void {
			var count:int = 0;
			Enumerable.Times(4, function(){count++});
			
			assertThat(count, equalTo(4));
		}
		
		[Test]
		public function Times_Does_Something_N_Times_With_Parameter():void {
			var count:int = 0;
			Enumerable.Times(4, function(x){count+= x});
			
			assertThat(count, equalTo(6));
		}
		
		[Test]
		public function noneIfEmpty_is_some_if_it_is_not_empty():void {
			var result:Option = [1,2,3].noneIfEmpty();
			
			assertThat(result.value.ToArray(), array(1,2,3));
		}
		
		[Test]
		public function noneIfEmpty_is_none_if_it_is_empty():void {
			var result:Option = [].noneIfEmpty();
			
			assertThat(result.isNone);
		}
	}
}