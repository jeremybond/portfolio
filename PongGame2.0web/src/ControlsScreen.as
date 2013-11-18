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
	public class ControlsScreen extends ControlsScreenMC
	{
		public static const BACK	:	String 	=	"back"; 
		
		public function ControlsScreen() 
		{
			menuBtn.addEventListener		(MouseEvent.CLICK, BackClick);
		}
		
		private function BackClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event(BACK));
			
		}
		
	}

}