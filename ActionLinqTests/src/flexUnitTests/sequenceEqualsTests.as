package flexUnitTests
{
	import System.Linq.Enumerable;
	
	import flash.sampler.NewObjectSample;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class sequenceEqualsTests extends EnumerableTestsBase
	{		
		[Test]
		public function sequenceEqual_is_true_when_sequences_are_equal():void {
			var first:Array = [1,2,3];
			var second:Array = [1,2,3];
			
			assertThat(first.sequenceEqual(Enumerable.From(second)));
		}
		
		[Test]
		public function sequenceEqual_is_false_when_sequences_of_same_length_have_different_values():void {
			var first:Array = [1,2,3];
			var second:Array = [1,2,4];
			
			assertThat(first.sequenceEqual(Enumerable.From(second)), equalTo(false));
		}
		
		[Test]
		public function sequenceEqual_is_false_when_frst_is_longer_than_second():void {
			var first:Array = [1,2,3,4];
			var second:Array = [1,2,3];
			
			assertThat(first.sequenceEqual(Enumerable.From(second)), equalTo(false));
		}
		
		[Test]
		public function sequenceEqual_is_false_when_second_is_longer_than_first():void {
			var first:Array = [1,2,3];
			var second:Array = [1,2,3,4];
			
			assertThat(first.sequenceEqual(Enumerable.From(second)), equalTo(false));
		}
		
		[Test(expected="ArgumentError")]
		public function sequenceEqual_throws_ArgumentError_when_second_is_null():void {
			var first:Array = [1,2,3];
			
			var equal:Boolean = first.sequenceEqual(null);
		}
		
		[Test]
		public function sequenceEqual_with_comparer_is_true_when_sequences_are_equal():void {
			var first:Array = [new TestModel("brian", 33, 12345), new TestModel("cara", 34, 23456), new TestModel("maia", 4, 34567)];
			var second:Array = [new TestModel("brian", 33, 12345), new TestModel("cara", 34, 23456), new TestModel("maia", 4, 34567)];
			
			assertThat(first.sequenceEqual(Enumerable.From(second), new ModelComparator()));
		}
		
		[Test]
		public function sequenceEqual_with_comparer_is_false_when_sequences_of_same_length_have_different_values():void {
			var first:Array = [new TestModel("brian", 33, 12345), new TestModel("cara", 34, 23456), new TestModel("maia", 4, 34567)];
			var second:Array = [new TestModel("brian", 33, 12345), new TestModel("cara", 34, 23456), new TestModel("maia", 4, 45678)];
			
			assertThat(first.sequenceEqual(Enumerable.From(second), new ModelComparator()), equalTo(false));
		}
		
		[Test]
		public function sequenceEqual_with_comparer_is_false_when_frst_is_longer_than_second():void {
			var first:Array = [new TestModel("brian", 33, 12345), new TestModel("cara", 34, 23456), new TestModel("maia", 4, 34567), new TestModel("eli", 0, 56789)];
			var second:Array = [new TestModel("brian", 33, 12345), new TestModel("cara", 34, 23456), new TestModel("maia", 4, 34567)];
			
			assertThat(first.sequenceEqual(Enumerable.From(second), new ModelComparator()), equalTo(false));
		}
		
		[Test]
		public function sequenceEqual_with_comparer_is_false_when_second_is_longer_than_first():void {
			var first:Array = [new TestModel("brian", 33, 12345), new TestModel("cara", 34, 23456), new TestModel("maia", 4, 34567)];
			var second:Array = [new TestModel("brian", 33, 12345), new TestModel("cara", 34, 23456), new TestModel("maia", 4, 34567), new TestModel("eli", 0, 56789)];
			
			assertThat(first.sequenceEqual(Enumerable.From(second), new ModelComparator()), equalTo(false));
		}
		
	}
}