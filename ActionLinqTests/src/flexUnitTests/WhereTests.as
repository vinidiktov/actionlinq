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
			var enumerator:IEnumerator = filtered.getEnumerator();
			
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(4));
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(5));
			assertThat(enumerator.MoveNext(), equalTo(false));
		}
		
		[Test]
		public function Where_with_static_predicate_and_no_index_does_not_fail(): void
		{
			var filtered:Array = [1, 2, 3, 4, 5].Where(greaterOrEqual4).toArray();
			
			assertThat(filtered, array(4,5));
		}
		
		private function greaterOrEqual4(x) { return x >= 4 }
		
		[Test]
		public function Where_With_Index_Passes_Index_If_Defined():void {
			var data:Array = 
				[1, 2, 3, 4, 5]
				.Where(function(x,i) { return i  < 3 })
				.toArray();
			
			assertThat(data, array(1,2,3));
		}
		
		[Test]
		public function Resetting_Where_Starts_Over()
		{
			var data:Array = [1, 2, 3, 4, 5];
			var filtered:IEnumerable = data.Where(function(x){return x >= 4});
			var enumerator:IEnumerator = filtered.getEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			assertThat(enumerator.Current(), equalTo(4));
		}
		
	}
}