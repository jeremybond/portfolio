package ThePackage.BackGroundStuff 
{
	import flash.events.Event;
	import ThePackage.Main;
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class WalkerWoman extends Human
	{
		private var art:humanArt4;
		public function WalkerWoman() 
		{
			art = new humanArt4;
			addChild(art);
			
			id = ("WalkerRight");
			speed = 5;
			left = false;
			PosZ = -1;
			position = 810;
			//addEventListener(Event.ADDED_TO_STAGE, init);
		//}
		//
		//private function init(e:Event):void 
		//{
			//removeEventListener(Event.ADDED_TO_STAGE, init);
			//position = (stage.stageWidth + 10);
		}
		
		
	}

}