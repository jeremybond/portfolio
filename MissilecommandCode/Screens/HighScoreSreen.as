package ThePackage.Screens 
{
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ThePackage.Main;
	import flash.system.fscommand;
	
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class HighScoreSreen extends HighScoreScreenArt
	{
		public static const BACK	:	String 	=	"back"; 
		
		public function HighScoreSreen() 
		{
			BackBtn.addEventListener		(MouseEvent.CLICK, BackClick);
			
		}
		
		private function BackClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event(BACK));
			
		}
		
	}

}