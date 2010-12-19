package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Collection.Generic.IGrouping;
	import System.Collection.Generic.ILookup;
	import System.Linq.Grouping;
	import System.Linq.Lookup;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class LookupTests
	{		
		[Test]
		public function Lookup_is_an_IEnumerable_of_IGroupings():void {
			var lookup:ILookup = new Lookup([new Grouping("a"), new Grouping("b")]);
			var items:Array = lookup.toArray();
			
			assertThat(items.length, equalTo(2));
			assertThat(items[0] is IGrouping);
			assertThat(items[1] is IGrouping);
		}
		
		[Test(expected="ArgumentError")]
		public function Lookup_with_items_not_IGrouping_throws_ArgumentError():void {
			var lookup:ILookup = new Lookup([""]);
		}
		
		[Test]
		public function Lookup_with_no_items_is_just_empty():void {
			var lookup:Array = new Lookup().toArray();
			
			assertThat(lookup.length, equalTo(0));
		}
		
		[Test]
		public function adding_item_to_lookup_generates_IGrouping():void {
			var lookup:Lookup = new Lookup();
			
			lookup.add("111", 2);
			
			var items:Array = lookup.toArray();
			
			assertThat(items.length, equalTo(1));
			assertThat(items[0] is IGrouping);
			assertThat(items[0].key, equalTo("111"));
			assertThat(items[0].toArray(), array(2));
		}
		
		[Test]
		public function adding_two_items_with_different_keys_generates_two_IGroupings():void {
			var lookup:Lookup = new Lookup();
			
			lookup.add("111", 2);
			lookup.add("222", 4);
			
			var items:Array = lookup.toArray();
			
			assertThat(items.length, equalTo(2));
			assertThat(items[0] is IGrouping);
			assertThat(items[1] is IGrouping);
		}
		
		[Test]
		public function adding_two_items_with_same_key_generates_one_IGrouping():void {
			var lookup:Lookup = new Lookup();
			
			lookup.add("111", 2);
			lookup.add("111", 4);
			
			var items:Array = lookup.toArray();
			
			assertThat(items.length, equalTo(1));
			assertThat(items[0].key, equalTo("111"));
			assertThat(items[0].toArray(), array(2,4));
		}
		
		[Test]
		public function lookup_will_find_grouping_by_key():void {
			var lookup:Lookup = new Lookup();
			
			lookup.add("111", 2);
			lookup.add("111", 4);
			lookup.add("222", 6);
			lookup.add("222", 8);
			
			var group111:IGrouping = lookup.lookup("111");
			var group222:IGrouping = lookup.lookup("222");
			
			assertThat(group111.key, equalTo("111"));
			assertThat(group111.toArray(), array(2,4));
			assertThat(group222.key, equalTo("222"));
			assertThat(group222.toArray(), array(6,8));
		}
	}
}