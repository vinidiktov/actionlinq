package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	import System.Collection.Generic.IOrderedEnumerable;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class OrderByTests extends EnumerableTestsBase
	{		
		[Test]
		public function orderBy_sorts_given_the_keySelector():void {
			var ordered:IOrderedEnumerable = ["red", "green", "blue", "purple"]
				.orderBy(function(item:String):int { return item.length; });
			
			assertThat(ordered.toArray(), array("red", "blue", "green", "purple"));
		}
		
		[Test]
		public function resetting_orderBy_causes_it_to_go_back_to_beginning() {
			var orderedEnumerator:IEnumerator = ["red", "green", "blue", "purple"]
				.orderBy(function(item:String):int { return item.length; })
				.GetEnumerator();
			
			orderedEnumerator.MoveNext();
			orderedEnumerator.MoveNext();
			orderedEnumerator.Reset();
			orderedEnumerator.MoveNext();
			
			assertThat(orderedEnumerator.Current(), equalTo("red"));
		}
		
		
	}
}