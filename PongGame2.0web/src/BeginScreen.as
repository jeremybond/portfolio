package  
{
	import adobe.utils.CustomActions;
	import flash.events.AccelerometerEvent;
	
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
	public class BeginScreen extends StartscreenMC2
	{
		public static const START		:	String	=	"start";
		public static const CONTROLS	:	String 	=	"controls"; 
		public static const CREDITS		:	String 	=	"credits"; 
		
		public function BeginScreen() 
		{
			playBtn.addEventListener		(MouseEvent.CLICK, StartClick);
			controlBtn.addEventListener		(MouseEvent.CLICK, ControlsClick);
			creditsBtn.addEventListener		(MouseEvent.CLICK, CreditsClick);
	//		exitBtn.addEventListener		(MouseEvent.CLICK, ExitClick);
		}
		
		
		
		private function StartClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event(START));
		}
		private function ControlsClick(e:MouseEvent):void 
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