package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class Sneeuwbal extends MovieClip
	{
		private var art:MovieClip;
		public function Sneeuwbal() 
		{
			art = new sneeuwbal;
			addChild(art);
			x = 1000;
			y = 100;
		//	art.x = 1300;
		//	art.y = (Math.random() * 700);
			
		}
		public function move():void
		{
			
			x -= 10;
			
		}
		
	}

}