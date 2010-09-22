package System.Collection.Generic
{
	public interface IEnumerator
	{
		function MoveNext():Boolean;
		function Current():*;
		function Reset():void;
	}
}