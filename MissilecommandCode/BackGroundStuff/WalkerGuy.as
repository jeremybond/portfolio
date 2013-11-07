package ThePackage.BackGroundStuff 
{
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class WalkerGuy extends Human
	{
		private var art:humanArt2;
		public function WalkerGuy() 
		{
			art = new humanArt2;
			addChild(art);
			
			id = ("WalkerLeft");
			position = -10;
			speed = 5;
			left = true;
			PosZ = -1;
		}
		
	}

}