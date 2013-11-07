package ThePackage.BackGroundStuff 
{
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class RunnerGuy extends Human
	{
		private var art:humanArt1;
		public function RunnerGuy() 
		{
			art = new humanArt1;
			addChild(art);
			
			id = ("RunnerLeft");
			position = -10;
			speed = 10;
			left = true;
			PosZ = -1;
			
		}
		
	}

}