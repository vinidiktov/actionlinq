package
{
	import Array;
	
	import flash.display.Sprite;
	
	import flexUnitTests.EnumerableTests;
	import flexUnitTests.FirstTests;
	import flexUnitTests.SelectTests;
	import flexUnitTests.ToArrayTests;
	import flexUnitTests.WhereTests;
	
	import flexunit.flexui.FlexUnitTestRunnerUIAS;
	
	public class FlexUnitApplication extends Sprite
	{
		public function FlexUnitApplication()
		{
			onCreationComplete();
		}
		
		private function onCreationComplete():void
		{
			var testRunner:FlexUnitTestRunnerUIAS=new FlexUnitTestRunnerUIAS();
			this.addChild(testRunner); 
			testRunner.runWithFlexUnit4Runner(currentRunTestSuite(), "ActionLinq");
		}
		
		public function currentRunTestSuite():Array
		{
			var testsToRun:Array = new Array();
			testsToRun.push(flexUnitTests.EnumerableTests);
			testsToRun.push(flexUnitTests.FirstTests);
			testsToRun.push(flexUnitTests.SelectTests);
			testsToRun.push(flexUnitTests.ToArrayTests);
			testsToRun.push(flexUnitTests.WhereTests);
			return testsToRun;
		}
	}
}