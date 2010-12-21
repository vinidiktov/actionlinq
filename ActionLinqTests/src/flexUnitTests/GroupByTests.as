package flexUnitTests
{
	import System.Collection.Generic.IGrouping;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class GroupByTests extends EnumerableTestsBase
	{		
		[Test]
		public function groupBy_with_keySelector_groups_items():void {
			var data:Array = [
				{ name: "Barley",   age: 8 },
				{ name: "Boots",    age: 4 },
				{ name: "Whiskers", age: 1 },
				{ name: "Daisy",    age: 4 }];
			
			var grouping:Array = data.groupBy(function(pet) { return pet.age }).toArray();
			
			assertThat(grouping.length, equalTo(3));
			assertThat(grouping[0].key, equalTo(8));
			assertThat(grouping[0].first().name, equalTo("Barley"));
			
			assertThat(grouping[1].key, equalTo(4));
			assertThat(grouping[1].first().name, equalTo("Boots"));
			assertThat(grouping[1].last().name, equalTo("Daisy"));
			
			assertThat(grouping[2].key, equalTo(1));
			assertThat(grouping[2].first().name, equalTo("Whiskers"));
		}
		
		[Test]
		public function groupBy_with_keySelector_and_elementSelector_groups_items():void {
			var data:Array = [
				{ name: "Barley",   age: 8 },
				{ name: "Boots",    age: 4 },
				{ name: "Whiskers", age: 1 },
				{ name: "Daisy",    age: 4 }];
			
			var grouping:Array = data.groupBy(function(pet) { return pet.age }, function(pet) { return pet.name }).toArray();
			
			assertThat(grouping.length, equalTo(3));
			assertThat(grouping[0].key, equalTo(8));
			assertThat(grouping[0].first(), equalTo("Barley"));
			
			assertThat(grouping[1].key, equalTo(4));
			assertThat(grouping[1].first(), equalTo("Boots"));
			assertThat(grouping[1].last(), equalTo("Daisy"));
			
			assertThat(grouping[2].key, equalTo(1));
			assertThat(grouping[2].first(), equalTo("Whiskers"));
		}
		
		[Test]
		public function groupBy_with_keySelector_and_results_selector_and_selects_results():void {
			var data:Array = [
				{ name: "Barley",   age: 8.3 },
				{ name: "Boots",    age: 4.9 },
				{ name: "Whiskers", age: 1.5 },
				{ name: "Daisy",    age: 4.3 }];
			
			var grouping:Array = data
								.groupBy(function(pet) { return Math.floor(pet.age) },
										 null,
										 function(age, pets) { return {
											 					key:   age, 
																count: pets.Count(), 
																min:   pets.Min(function(pet) { return pet.age }), 
																max:   pets.Max(function(pet) { return pet.age }) }})
								.Select(function(x) { return x.key + " " + x.count + " " + x.min + " " + x.max}) 
								.toArray();
			
			assertThat(grouping, array("8 1 8.3 8.3", "4 2 4.3 4.9", "1 1 1.5 1.5"));
		}
		
		[Test]
		public function groupBy_with_keySelector_elementSelector_and_resultsSelector_selects_results():void {
			var data:Array = [
				{ name: "Barley",   age: 8.3 },
				{ name: "Boots",    age: 4.9 },
				{ name: "Whiskers", age: 1.5 },
				{ name: "Daisy",    age: 4.3 }];
			
			var grouping:Array = data
								.groupBy(function(pet) { return Math.floor(pet.age) },
										 function(pet) { return pet.age },
										 function(baseAge, ages) { return {
																key:   baseAge, 
																count: ages.Count(), 
																min:   ages.Min(), 
																max:   ages.Max() }})
				.Select(function(x) { return x.key + " " + x.count + " " + x.min + " " + x.max}) 
				.toArray();
			
			assertThat(grouping, array("8 1 8.3 8.3", "4 2 4.3 4.9", "1 1 1.5 1.5"));
		}
		
		[Test(expected="ArgumentError")]
		public function groupBy_throws_ArgumentError_with_null_keySelector():void {
			var grouping = [].groupBy(null);
		}
		
	}
}