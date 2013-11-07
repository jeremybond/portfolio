package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class Vuurtje extends Vuur
	{
		private var art:MovieClip;
		public function Vuurtje() 
		{
			art = new fire;
			addChild(art);
			x = 1000;
			y = 375;
			
			
			
		}
		public function move3():void
		{
			
			x -= 15;
		}
	}

}