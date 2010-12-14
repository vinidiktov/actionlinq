package System.Linq.Option
{
	public class Option
	{
		private var _isSome:Boolean;
		private var _value:*;

		public function Option(isSome:Boolean=false, value:*=null)
		{
			_isSome = isSome;
			_value = value;
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

		public function get isSome():Boolean
		{
			return _isSome;
		}
	}
}