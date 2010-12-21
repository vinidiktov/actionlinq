package flexUnitTests
{
	import System.Collection.Generic.*;
	import System.Linq.*;
	
	import flexunit.framework.*;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;
	
	public class SelectTests extends EnumerableTestsBase
	{
		[Test]
		public function select_maps_values_to_function():void
		{
			var mapped:IEnumerable = [1,2].select(function(x){return x*2});
			
			var enumerator:IEnumerator = mapped.getEnumerator();
			
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(2));
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(4));
			assertThat(enumerator.MoveNext(), equalTo(false));
		}	
		
		[Test]
		public function select_with_static_function_and_no_index_does_not_fail():void {
			var mapped:Array = [1,2].select(Times2).toArray();
			
			assertThat(mapped, array(2,4));
		}
		
		private function Times2(x) { return x * 2 }
		
		[Test]
		public function select_with_index_passes_index_into_function():void {
			var mapped:Array = 
				[1,2,3,4]
				.select(function(x,i) { return x * i })
				.toArray();
			
			assertThat(mapped, array(0, 2, 6, 12));
		}
		
		[Test]
		public function selector_is_only_called_once_per_move(): void {
			var increment:int = 0;
			var mapped:IEnumerator = [1].select(function(x){return increment++}).getEnumerator();
			
			mapped.MoveNext();
			
			assertThat(mapped.Current(), equalTo(0));
			assertThat(mapped.Current(), equalTo(0));
		}
		
		[Test]
		public function resetting_select_starts_over()
		{
			var mapped:IEnumerable = [1,2].select(function(x){return x*2});
			var enumerator:IEnumerator = mapped.getEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			assertThat(enumerator.Current(), equalTo(2));
		}
		
		[Test(expected="ArgumentError")]
		public function select_throws_ArgumentError_when_selector_is_null():void {
			var mapped = [].select(null);
		}
	}
}