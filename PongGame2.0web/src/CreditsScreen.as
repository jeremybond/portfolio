package  
{
	import adobe.utils.CustomActions;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.fscommand;
	
	import Main;
	
	/**
	 * ...
	 * @author kerim birlik && jeremy bond
	 */
	public class CreditsScreen extends CreditsScreenMC
	{
		public static const BACK	:	String 	=	"back"; 
		
		public function CreditsScreen() 
		{
			menuBtn.addEventListener		(MouseEvent.CLICK,		backToMenu)
		}
		
		private function backToMenu(e:MouseEvent):void 
		{
			dispatchEvent(new Event(BACK));
		}
	}

}