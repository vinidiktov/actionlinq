package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	import System.Collection.Generic.IOrderedEnumerable;
	
	import flash.sampler.NewObjectSample;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class OrderByTests extends EnumerableTestsBase
	{		
		[Test]
		public function orderBy_sorts_given_the_keyselector():void {
			var ordered:IOrderedEnumerable = ["red", "green", "blue", "purple"]
				.orderBy(function(item:String):int { return item.length; });
			
			assertThat(ordered.toArray(), array("red", "blue", "green", "purple"));
		}
		
		[Test]
		public function resetting_orderBy_causes_it_to_go_back_to_beginning() {
			var orderedEnumerator:IEnumerator = ["red", "green", "blue", "purple"]
				.orderBy(function(item:String):int { return item.length; })
				.getEnumerator();
			
			orderedEnumerator.MoveNext();
			orderedEnumerator.MoveNext();
			orderedEnumerator.Reset();
			orderedEnumerator.MoveNext();
			
			assertThat(orderedEnumerator.Current(), equalTo("red"));
		}
		
		[Test]
		public function orderBy_with_comparator_orders_with_comparator():void {
			var data:Array = [
				new TestModel("brian", 33, 12345),
				new TestModel("cara", 34, 23456),
				new TestModel("maia", 3, 34567) ];
			
			var ordered:Array = 
				data
				.orderBy(function(item) { return item; }, new ModelComparator())
				.select(function(item) { return item.name})
				.toArray();
			
			assertThat(ordered, array("maia", "brian", "cara"));
		}
		
		[Test(expected="ArgumentError")]
		public function orderBy_throws_ArgumentError_when_keyselector_is_null():void {
			var ordered = [].orderBy(null);
		}
		
		[Test]
		public function orderByDescending_sorts_given_the_keyselector_descended():void {
			var ordered:IOrderedEnumerable = ["red", "green", "blue", "purple"]
				.orderByDescending(function(item:String):int { return item.length; });
			
			assertThat(ordered.toArray(), array("purple", "green", "blue", "red"));
		}
		
		[Test]
		public function orderByDescending_with_comparator_orders_descended_with_comparator():void {
			var data:Array = [
				new TestModel("brian", 33, 12345),
				new TestModel("cara", 34, 23456),
				new TestModel("maia", 3, 34567) ];
			
			var ordered:Array = 
				data
				.orderByDescending(function(item) { return item; }, new ModelComparator())
				.select(function(item) { return item.name})
				.toArray();
			
			assertThat(ordered, array("cara", "brian", "maia"));
		}
		
		[Test(expected="ArgumentError")]
		public function orderByDescending_throws_ArgumentError_when_keyselector_is_null():void {
			var ordered = [].orderByDescending(null);
		}
		
		[Test]
		public function thenBy_uses_second_criteria_for_sorting():void {
			var data:Array = ["one", "two", "three", "four", "five", "six"];
			var ordered:Array = data
							.orderBy(function(x:String) { return x.length })
							.thenBy(function(x:String) { return x })
							.toArray();
							
			assertThat(ordered, array("one", "six", "two", "five", "four", "three"));
		}
		
		[Test]
		public function thenBy_uses_second_criteria_with_comparator_for_sorting():void {
			var data:Array = [
				new TestModel("brian", 33, 12345),
				new TestModel("cara", 34, 23456),
				new TestModel("maia", 3, 34567),
			    new TestModel("eli", 0, 45678)];
			
			var ordered:Array = 
				data
				.orderBy(function(item) { return item.name.length })
				.thenBy(function(item) { return item }, new ModelComparator())
				.select(function(item) { return item.name})
				.toArray();
			
			assertThat(ordered, array("eli", "maia", "cara", "brian"));
		}
		
		[Test(expected="ArgumentError")]
		public function thenBy_throws_ArgumentError_when_keyselector_is_null():void {
			var ordered = [3,4,5]
							.orderBy(function(x) { return x })
							.thenBy(null);
		}
		
		[Test]
		public function thenByDescending_uses_second_criteria_for_sorting():void {
			var data:Array = ["one", "two", "three", "four", "five", "six"];
			var ordered:Array = data
				.orderBy(function(x:String) { return x.length })
				.thenByDescending(function(x:String) { return x })
				.toArray();
			
			assertThat(ordered, array("two", "six", "one", "four", "five", "three"));
		}
		
		[Test]
		public function thenByDescending_uses_second_criteria_with_comparator_for_sorting():void {
			var data:Array = [
				new TestModel("brian", 33, 12345),
				new TestModel("maia", 3, 34567),
				new TestModel("cara", 34, 23456),
				new TestModel("eli", 0, 45678)];
			
			var ordered:Array = 
				data
				.orderBy(function(item) { return item.name.length })
				.thenByDescending(function(item) { return item }, new ModelComparator())
				.select(function(item) { return item.name})
				.toArray();
			
			assertThat(ordered, array("eli", "cara", "maia", "brian"));
		}
		
		[Test(expected="ArgumentError")]
		public function thenByDescending_throws_ArgumentError_when_keyselector_is_null():void {
			var ordered = [3,4,5]
				.orderBy(function(x) { return x })
				.thenByDescending(null);
		}
		
		[Test]
		public function thenBy_many_times_will_sort_with_multiple_criteria():void {
			var data:Array = [
				new TestModel("brian", 33, 1),
				new TestModel("cara", 2, 8),
				new TestModel("maia", 88, 3),
				new TestModel("brian", 34, 6),
				new TestModel("cara", 3, 2),
				new TestModel("maia", 1, 7),
				new TestModel("brian", 33, 5),
				new TestModel("cara", 2, 4),
				new TestModel("maia", 88, 9)];
			
			var ordered = data
							.orderBy(function(x) { return x.name })
							.thenBy(function(x) { return x.age })
							.thenBy(function(x) { return x.soc })
							.select(function(x) { return x.name + " " + x.age + " " + x.soc })
							.toArray();
			
			assertThat(ordered, array("brian 33 1", "brian 33 5", "brian 34 6", "cara 2 4", "cara 2 8", "cara 3 2", "maia 1 7", "maia 88 3", "maia 88 9"));		
		}
		
	}
}