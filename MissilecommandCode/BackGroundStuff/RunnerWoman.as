package ThePackage.BackGroundStuff 
{
	import flash.events.Event;
	import ThePackage.Main;
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class RunnerWoman extends Human
	{
		private var art:humanArt3;
		public function RunnerWoman() 
		{
			art = new humanArt3;
			addChild(art);
			
			name = ("RunnerRight");
			speed = 10;
			left = false;
			position = 810;
			PosZ = -1;
			
			
		}
		
		
		
	}

}