package ThePackage.Crap 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class StarCrap extends Crap
	{
		private var art:Crap1Art;
		public function StarCrap() 
		{
			art = new Crap1Art();
			addChild(art);
			
			id = "Star";
			splice = true;
			damage = 20;
			speed = ((Math.random() * 2) + 3);
		}
	}

}