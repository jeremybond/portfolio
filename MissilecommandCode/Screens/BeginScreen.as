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
	public class BeginScreen extends beginScreenArt
	{
		
		public static const START		:	String	=	"start";
		public static const SCORE		:	String 	=	"score"; 
		public static const FULLSCRN	:	String 	=	"fullscreen";
		
		public function BeginScreen() 
		{
			startBtn.addEventListener		(MouseEvent.CLICK, StartClick);
			fullScreenBtn.addEventListener	(MouseEvent.CLICK, GoFullScreen);
			scoreBtn.addEventListener		(MouseEvent.CLICK, HighScoreClick);
			exitBtn.addEventListener		(MouseEvent.CLICK, ExitClick);
		}
		
		
		private function StartClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event(START));
		}
		private function GoFullScreen(e:MouseEvent):void 
		{
			dispatchEvent(new Event(FULLSCRN));
		}
		private function HighScoreClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event(SCORE));
		}
		private function ExitClick(e:MouseEvent):void 
		{
			fscommand("quit");
		}
		
		
		
		
		
	}

}