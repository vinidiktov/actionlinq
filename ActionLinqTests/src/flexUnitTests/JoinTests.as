package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;

	public class JoinTests extends EnumerableTestsBase
	{		
		[Test]
		public function join_joins_two_collections_into_a_collection_of_a_new_type():void {
			var magnus:* = { Name: "Hedlund, Magnus" };
			var terry:* = { Name: "Adams, Terry" };
			var charlotte:* = { Name: "Weiss, Charlotte" };
			
			var barley:* = { Name: "Barley", Owner: terry };
			var boots:* = { Name: "Boots", Owner: terry };
			var whiskers:* = { Name: "Whiskers", Owner: charlotte };
			var daisy:* = { Name: "Daisy", Owner: magnus };
			
			var people:Array = [ magnus, terry, charlotte ];
			var pets:Array = [ barley, boots, whiskers, daisy ];
			
			var query:IEnumerable = people.joinEnumerables(pets.AsEnumerable(), 
					function(person:*):* {return person},
					function(pet:*):* { return pet.Owner},
					function(person, pet) { return {OwnerName: person.Name, Pet: pet.Name}; });
			
			var output:Array = query.toArray();
			
			assertThat(output[0].OwnerName, equalTo("Hedlund, Magnus"));
			assertThat(output[0].Pet, equalTo("Daisy"));
			assertThat(output[1].OwnerName, equalTo("Adams, Terry"));
			assertThat(output[1].Pet, equalTo("Barley"));
			assertThat(output[2].OwnerName, equalTo("Adams, Terry"));
			assertThat(output[2].Pet, equalTo("Boots"));
			assertThat(output[3].OwnerName, equalTo("Weiss, Charlotte"));
			assertThat(output[3].Pet, equalTo("Whiskers"));
		}
		
		private function noOp(x, y=null) {}
		
		[Test(expected="ArgumentError")]
		public function join_throws_ArgumentError_when_inner_is_null():void {
			var query:IEnumerable = [1,2,3].AsEnumerable().join(null, noOp, noOp, noOp);
		}
		
		[Test(expected="ArgumentError")]
		public function join_throws_ArgumentError_when_outerKeySelector_is_null():void {
			var query:IEnumerable = [1,2,3].AsEnumerable().join([].AsEnumerable(), null, noOp, noOp);
		}
		
		[Test(expected="ArgumentError")]
		public function join_throws_ArgumentError_when_innerKeySelector_is_null():void {
			var query:IEnumerable = [1,2,3].AsEnumerable().join([].AsEnumerable(), noOp, null, noOp);
		}
		
		[Test(expected="ArgumentError")]
		public function join_throws_ArgumentError_when_resultSelector_is_null():void {
			var query:IEnumerable = [1,2,3].AsEnumerable().join([].AsEnumerable(), noOp, noOp, null);
		}
		
	}
}