package flexUnitTests
{
	import System.Collection.Generic.IEnumerable;
	import System.Linq.Enumerable;
	import System.Linq.EnumerationExtender;
	import System.Linq.FunctionBuilder.element;
	import System.Linq.FunctionBuilder.identity;
	import System.Linq.Option.Option;
	
	import flash.net.dns.AAAARecord;
	
	import mx.collections.ArrayCollection;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;
	
	import spark.components.DropDownList;

	public class Examples
	{		
		[Before]
		public function before():void {
			EnumerationExtender.InitializeClass(Array);
		}
		
		[Test]
		public function simple_example_of_mapping_even_squares_and_distinct():void {
			var transformed:Array =
				[-4, -3, -2, -1, 0, 1, 2, 3, 4]
				.where(isEven)
				.select(square)
				.distinct()
				.reverse()
				.toArray();
			
			assertThat(transformed, array(0, 4, 16));
		}
		
		private static function isEven(num:int):Boolean { return num % 2 == 0 }
		private static function square(num:int):int     { return num * num }
		
		[Test]
		public function translate_xml_for_display_to_a_DropdownList():void {
			var xml = <products>
						<product name="Beef"         category="Meat" />
						<product name="Hot Dog Buns" category="Bread" />
						<product name="Bran Flakes"  category="Cereal" />
						<product name="Chicken"      category="Meat" />
						<product name="White Bread"  category="Bread" />
						<product name="Pita Bread"   category="Bread" />
					  </products>;
			
			var categories:ArrayCollection =
				Enumerable.from(xml.product)
				.select(function(product):String { return product.@category })
				.distinct()
				.orderBy(identity)
				.toArrayCollection();
			
			
			// categories is ready for a DropDownList.dataProvider with ["Bread", "Cereal", "Meat"]
			assertThat(categories.source, array("Bread", "Cereal", "Meat"));		
		}
		
		[Test]
		public function joining_tables():void {
			var customers:Array = [ 
				{id: 1111, name: "John"},
				{id: 2222, name: "Jane" },
				{id: 3333, name: "Jack" }];
		
			var orders:Array = [ 
				{id: 1234, name: "Beef",        customer: 2222 },
				{id: 2345, name: "Bran Flakes", customer: 3333 },
				{id: 3456, name: "Chicken",     customer: 1111 }];
			
			var joined = customers.joinEnumerables(orders.asEnumerable(),
				function(customer)        { return customer.id },
				function(order)           { return order.customer },
				function(customer, order) { return {name: customer.name, product: order.name } });
			
			var joinedStrings = joined.select(function(join) { return join.name + ": " + join.product }).toArray();
			
			// returns {name: "John", product: "Chicken"}, {name: "Jane", product: "Beef"}, {name: "Jack", product: "Bran Flakes"}
			assertThat(joinedStrings, array("John: Chicken", "Jane: Beef", "Jack: Bran Flakes"));
		}
		
		[Test]
		public function using_function_builder_for_predicates() {
			var greaterThan10:Array = 
				[8, 9, 10, 11, 12, 13]
				.where(function(element) { return element > 10})
				.toArray();
			
			assertThat(greaterThan10, array(11, 12, 13));
			
			var greaterThan10:Array = 
				[8, 9, 10, 11, 12, 13]
				.where(element.isGreaterThan(10))
				.toArray();
			
			assertThat(greaterThan10, array(11, 12, 13));
		}
		
		[Test]
		public function using_function_builder_for_selectors() {
			var data = [{name: "Brian", age: 33}, {name: "Maia", age: 4}, {name: "Eli", age: 0}];
			
			var ages:Array = data.select(function(element) { return element.age })
				.toArray();
			
			assertThat(ages, array(33, 4, 0));
			
			var ages:Array = data.select(element.age)
				.toArray();
			
			assertThat(ages, array(33, 4, 0));
		}
		
		[Test]
		public function joining_tables_with_FunctionBuilder():void {
			var customers:Array = [ 
				{id: 1111, name: "John"},
				{id: 2222, name: "Jane" },
				{id: 3333, name: "Jack" }];
			
			var orders:Array = [ 
				{id: 1234, name: "Beef",        customer: 2222 },
				{id: 2345, name: "Bran Flakes", customer: 3333 },
				{id: 3456, name: "Chicken",     customer: 1111 }];
			
			var joined = customers.joinEnumerables(orders.asEnumerable(),
				element.id,
				element.customer,
				function(customer, order) { return {name: customer.name, product: order.name } });
			
			var joinedStrings = joined.select(function(join) { return join.name + ": " + join.product }).toArray();
			
			// returns {name: "John", product: "Chicken"}, {name: "Jane", product: "Beef"}, {name: "Jack", product: "Bran Flakes"}
			assertThat(joinedStrings, array("John: Chicken", "Jane: Beef", "Jack: Bran Flakes"));
		}
		
		[Test]
		public function deferred_invoke():void {
			var data:Array = [1,2,3,4,5,6];
			
			var query = data
						.where(element.isGreaterThan(4))
						.select(function(x) { return x * x });
			
			for each(var item in query)
			    trace(item);
			
			var sum = query.sum();
			assertThat(sum, equalTo(25 + 36));
			
			data.push(7);
			
			sum = query.sum();
			assertThat(sum, equalTo(25 + 36 + 49));
			
			var query2 = data
				         .where(element.isGreaterThan(1))
						 .where(element.isGreaterThan(2))
						 .where(element.isGreaterThan(3))
						 .where(element.isGreaterThan(4))
						 .where(element.isGreaterThan(5))
						 .where(element.isGreaterThan(6));
			
			var forceResults = query2.toArray();
			assertThat(forceResults, array(7));		 
		}
		
		[Test]
		public function understanding_extension_methods():void {
			var data:Array = [1,2,3,4,5,6];
			var enumerableData:IEnumerable = Enumerable.from(data);
			var query:IEnumerable = enumerableData.where(element.isGreaterThan(5));
			
			var directQuery:IEnumerable = [1,2,3,4,5,6].where(element.isGreaterThan(5));
		}
		
		[Test]
		public function understanding_firstOrNone():void {
			var query:Option = [1,2,4,5,6].firstOrNone(element.isGreaterThan(6));
			var answer:int = query.isNone ? 0 : query.value;
			
			assertThat(answer, equalTo(0));
		}
		
	}
}