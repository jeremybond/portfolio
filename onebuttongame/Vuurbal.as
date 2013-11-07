package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class Vuurbal extends Vuur
	{
		private var art:MovieClip;
		public function Vuurbal() 
		{
			art = new firebal ;
			addChild(art);
			x = 1000;
			y = 100;
			
			
			
		}
		public function move2():void
		{
			
			x -= 10;
		
		}
		
	}

}