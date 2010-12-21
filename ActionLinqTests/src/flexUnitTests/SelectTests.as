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
		public function Select_Maps_Values_To_Function():void
		{
			var mapped:IEnumerable = [1,2].Select(function(x){return x*2});
			
			var enumerator:IEnumerator = mapped.getEnumerator();
			
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(2));
			assertThat(enumerator.MoveNext(), equalTo(true));
			assertThat(enumerator.Current(), equalTo(4));
			assertThat(enumerator.MoveNext(), equalTo(false));
		}	
		
		[Test]
		public function Select_with_static_function_and_no_index_does_not_fail():void {
			var mapped:Array = [1,2].Select(Times2).toArray();
			
			assertThat(mapped, array(2,4));
		}
		
		private function Times2(x) { return x * 2 }
		
		[Test]
		public function Select_With_Index_Passes_Index_Into_Function():void {
			var mapped:Array = 
				[1,2,3,4]
				.Select(function(x,i) { return x * i })
				.toArray();
			
			assertThat(mapped, array(0, 2, 6, 12));
		}
		
		[Test]
		public function Selector_Is_Only_Called_Once_Per_Move(): void {
			var increment:int = 0;
			var mapped:IEnumerator = [1].Select(function(x){return increment++}).getEnumerator();
			
			mapped.MoveNext();
			
			assertThat(mapped.Current(), equalTo(0));
			assertThat(mapped.Current(), equalTo(0));
		}
		
		[Test]
		public function Resetting_Select_Starts_Over()
		{
			var mapped:IEnumerable = [1,2].Select(function(x){return x*2});
			var enumerator:IEnumerator = mapped.getEnumerator();
			
			enumerator.MoveNext();
			enumerator.MoveNext();
			enumerator.Reset();
			enumerator.MoveNext();
			
			assertThat(enumerator.Current(), equalTo(2));
		}
	}
}