package System.Linq.FunctionBuilder
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	public dynamic class FunctionBuilder extends Proxy
	{
		public function isGreaterThan(value:Number):Function {
			return function(x:*):Boolean { return x > value };
		}
		
		public function isGreaterOrEqual(value:Number):Function {
			return function(x:*):Boolean { return x >= value };
		}
		
		public function isLessThan(value:Number):Function {
			return function(x:*):Boolean { return x < value };
		}
		
		public function isLessOrEqual(value:Number):Function {
			return function(x:*):Boolean { return x <= value };
		}
		
		public function isEqualTo(value:Number):Function {
			return function(x:*):Boolean { return x == value };
		}
		
		override flash_proxy function getProperty(propName:*):* {
			return function(x:*):* { return x[propName] };
		}
	}
}