package System.Collection.Generic
{
	public interface ILookup extends IEnumerable
	{
		function lookup(key:*):IGrouping;
	}
}