package System.Linq
{
	public class Option
	{
		private var _value:*;
		private var _isSome:Boolean;

		public function Option()
		{
			_isSome=false;
		}
		
		public function get value():*
		{
			if(_isSome == false)
				throw new Error("Option is none");

			return _value;
		}
		
		public function get isNone():Boolean
		{
			return !_isSome;
		}
		
		public static function some(value:*):Option
		{
			var returnValue = new Option();
			returnValue._value = value;
			returnValue._isSome = true;
			return returnValue;
		}
		
		public static function none():Option
		{
			return new Option();
		}
	}
}