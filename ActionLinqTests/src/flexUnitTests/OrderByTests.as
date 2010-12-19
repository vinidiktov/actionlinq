package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IEnumerator;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class OrderByTests extends EnumerableTestsBase
	{		
		[Test]
		public function OrderBy_Sorts_Given_The_keySelector_Function():void {
			var ordered:IEnumerable = ["red", "green", "blue", "purple"]
				.OrderBy(function(item:String):int { return item.length; });
			
			assertThat(ordered.toArray(), array("red", "blue", "green", "purple"));
		}
		
		[Test]
		public function Resetting_OrderBy_Causes_It_To_Go_Back_To_Beginning() {
			var orderedEnumerator:IEnumerator = ["red", "green", "blue", "purple"]
				.OrderBy(function(item:String):int { return item.length; })
				.GetEnumerator();
			
			orderedEnumerator.MoveNext();
			orderedEnumerator.MoveNext();
			orderedEnumerator.Reset();
			orderedEnumerator.MoveNext();
			
			assertThat(orderedEnumerator.Current(), equalTo("red"));
		}
		
	}
}