package flexUnitTests
{
	import System.Linq.*;
	
	import flash.utils.Dictionary;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public dynamic class ToArrayTests extends EnumerableTestsBase
	{		
		public function ToArrayTests() {
			this.foo = 1;
		}
		
		[Test]
		public function toArray_converts_IEnumerable_to_Array():void
		{
			assertThat(this.foo, equalTo(1));
			var converted:Array = [1,2].toArray();
			
			assertThat(converted.length, equalTo(2));
			assertThat(converted[0], equalTo(1));
			assertThat(converted[1], equalTo(2));
		}
		
		[Test]
		public function toArray_on_where_returns_Array()
		{
			var filtered:Array = [1,2,3,4,5].where(function(x){return x >= 4}).toArray();
			
			assertThat(filtered.length, equalTo(2));
			assertThat(filtered[0], equalTo(4));
			assertThat(filtered[1], equalTo(5));
		}
		
		[Test]
		public function toArrayCollection_converts_IEnumerable_to_ArrayCollection():void{
			var converted:ArrayCollection = [1,2].toArrayCollection();
			
			assertThat(converted.length, equalTo(2));
			assertThat(converted[0], equalTo(1));
			assertThat(converted[1], equalTo(2));
		}
		
		[Test]
		public function toList_converts_IEnumerable_to_IList():void {
			var converted:IList = [1,2].toList();
			
			assertThat(converted.length, equalTo(2));
			assertThat(converted.getItemAt(0), equalTo(1));
			assertThat(converted.getItemAt(1), equalTo(2));
		}
		
		[Test]
		public function toVector_converts_IEnumerable_to_Vector():void {
			var converted:Vector.<int> = 
				Enumerable.from(Vector.<int>([1,2,3]))
					.select(function(x){return x*x})
					.toVector(int);
			
			assertThat(converted.length, equalTo(3));
			assertThat(converted[0] is int && converted[0] == 1);
			assertThat(converted[1] is int && converted[1] == 4);
			assertThat(converted[2] is int && converted[2] == 9);
		}
		
		[Test]
		public function toVector_converts_IEnumerable_to_Vector_and_casts():void {
			var converted:Vector.<String> = 
				Enumerable.from(Vector.<int>([1,2,3]))
				.select(function(x){return x*x})
				.toVector(String);
			
			assertThat(converted.length, equalTo(3));
			assertThat(converted[0] is String && converted[0] == "1");
			assertThat(converted[1] is String && converted[1] == "4");
			assertThat(converted[2] is String && converted[2] == "9");
		}
		
		[Test]
		public function toVector_from_Array_extensions_passes_through():void {
			var vector:Vector.<int> = [1,2,3].toVector(int);
			
			assertThat(vector.length, equalTo(3));
			assertThat(vector[0] is int && vector[0] == 1);
			assertThat(vector[1] is int && vector[1] == 2);
			assertThat(vector[2] is int && vector[2] == 3);
		}
		
		
		[Test]
		public function toDictionary_converts_to_Dictionary():void {
			var dictionary:Dictionary = [1, 2].toDictionary(function(x) { return x.toString()});
			
			assertThat(dictionary.length(), equalTo(2));
			assertThat(dictionary["1"], equalTo(1));
			assertThat(dictionary["2"], equalTo(2));
		}
		
		[Test]
		public function toDictionary_with_elementSelector_converts_to_Dictionary():void {
			var dictionary:Dictionary = [1, 2].toDictionary(function(x) { return x }, function(x) { return x * 2 });
			
			assertThat(dictionary.length(), equalTo(2));
			assertThat(dictionary[1], equalTo(2));
			assertThat(dictionary[2], equalTo(4));
		}
		
		[Test(expected="ArgumentError")]
		public function toDictionary_throws_exception_if_keySelector_is_null():void {
			var dictionary:Dictionary = [1,2].toDictionary(null);
		}
		
		[Test(expected="ArgumentError")]
		public function toDictionary_throws_exception_when_keySelector_produces_a_key_that_is_null():void {
			var dictionary:Dictionary = [1].toDictionary(function(x){return null});
		}
		
		[Test(expected="ArgumentError")]
		public function toDictionary_throws_exception_when_keySelector_produces_duplicate_keys_for_two_elements():void {
			var dictionary:Dictionary = [1, 2].toDictionary(function(x){return 5});
		}
		
	}
}