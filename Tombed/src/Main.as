package 
{
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.StyleSheet;
	import Level.TileSystem;
	import Level.Lvls;
	import flash.display.Stage;
	import Player.Player;
	
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class Main extends Sprite
	{
		private var tyleSys:TileSystem = new TileSystem();
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			addChild(tyleSys);
		}
		
	}
	
}