package ThePackage.Crap 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import ThePackage.Main;
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class NormalCrap extends Crap
	{
		private var art:Crap2Art;
		public function NormalCrap() 
		{
			art = new Crap2Art();
			addChild(art);
			
			id = "Normal";
			splice = false;
			damage = 10;
			speed = ((Math.random() * 3) + 2);
			
		}
		
	}

}