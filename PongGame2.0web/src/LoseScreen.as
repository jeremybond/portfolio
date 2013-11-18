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
	public class LoseScreen extends LoseScreenMC
	{
		public static const MENU		:	String	=	"menu";
		public static const CONTROLS	:	String	=	"menu";
		public static const CREDITS		:	String	=	"menu";
		
		
		public function LoseScreen() 
		{
			menuBtn.addEventListener		(MouseEvent.CLICK, MenuClick);
			controlBtn.addEventListener		(MouseEvent.CLICK, ControlClick);
			creditsBtn.addEventListener		(MouseEvent.CLICK, CreditsClick);
	//		exitBtn.addEventListener		(MouseEvent.CLICK, ExitClick);
		}
		
		
		
		private function MenuClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event(MENU));
			trace("clickerdieclick");
		}
		private function ControlClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event(CONTROLS));
		}
		private function CreditsClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event(CREDITS));
		}
	//	private function ExitClick(e:MouseEvent):void 
	//	{
	//		fscommand("quit");
	//	}
		
	}

}