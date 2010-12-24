package flexUnitTests
{
	import System.Linq.Enumerable;
	import System.Linq.EnumerationExtender;
	import System.Linq.FunctionBuilder.element;
	import System.Linq.FunctionBuilder.identity;
	
	import mx.collections.ArrayCollection;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	
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
		
	}
}