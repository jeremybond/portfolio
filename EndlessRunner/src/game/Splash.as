package game 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Kit van de bunt
	 */
	public class Splash extends MovieClip
	{
		private var Screen:MovieClip = new SplashScreen();
		public function Splash() 
		{
			addChild(Screen);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		
		public function loop(e:Event):void
        {
			//waiting for animation to complete
			if (Screen.currentFrame >= Screen.totalFrames) {
				removeEventListener(Event.ENTER_FRAME, loop);
				
				//load menu sound
				soundHolder.sound_.initSound2();
				//remove this
				Main._main.RemoveSplash();
			}
		}
	}

}