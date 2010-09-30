package flexUnitTests
{
	import System.Collection.Generic.*;
	import System.Linq.*;
	
	import flexunit.framework.*;
	
	import mx.collections.ArrayCollection;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class WhereTests extends EnumerableTestsBase
	{	
		[Test]
		public function Where_Filters_On_Predicate(): void
		{
			var data:Array = [1, 2, 3, 4, 5];
			var filtered:IEnumerable = data.Where(function(x){return x >= 4});
			var enumerator:IEnumerator = filtered.GetEnumerator();
			
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(4));
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(5));
			assertThat(enumerator.MoveNext(), equalTo(false));
		}
		
		[Test]
		public function Static_Predicate_Without_Indexer_Doesnt_Fail(): void
		{
			var data:Array = [1, 2, 3, 4, 5];
			var filtered:IEnumerable = data.Where(GreaterOrEqualTo4);
			var enumerator:IEnumerator = filtered.GetEnumerator();
			
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(4));
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(5));
			assertThat(enumerator.MoveNext(), equalTo(false));
		}
		
		private function GreaterOrEqualTo4(i:int):Boolean {
			return i >= 4;
		}
		
		[Test]
		public function Where_With_Index_Passes_Index_If_Defined():void {
			var data:Array = 
				[1, 2, 3, 4, 5]
				.Where(function(x,i) { return i  < 3 })
				.ToArray();
			
			assertThat(data, array(1,2,3));
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
			
			assertThat(enumerator.Current(), equalTo(4));
		}
		
	}
}