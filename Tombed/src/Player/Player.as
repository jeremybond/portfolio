package Player
{
	import adobe.utils.CustomActions;
	import flash.display.InteractiveObject;
	import flash.display.InterpolationMethod;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.text.StyleSheet;
	import Level.TileSystem;
	
	/**
	 * ...
	 * @author Yornie Westink
	 **/
	public class Player extends MovieClip
	{

		private	var moveLeft		:	Boolean 				= false;
		private	var moveRight		:	Boolean 				= false;
		private	var moveUp			:	Boolean 				= false;
		private	var mDown			:	Boolean 				= false;
		public	var player_			:	playerWalk 			= new playerWalk();	
		
		public function Player():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			addChild(player_);
			player_.stop();
			player_.y = 32;
			player_.x = 12 * 32;
			
			
			stage.addEventListener(KeyboardEvent.KEY_UP,KeyUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,KeyDown);
			addEventListener(Event.ENTER_FRAME,EnterFrame);
		}
		
		private function KeyDown(e:KeyboardEvent):void 
		{
			switch(e.keyCode)
			{
				//Left
				case 37:
						moveLeft = true;
						moveRight = false;
				break;
				//Up
				case 38:
						moveUp = true;
						mDown = false;
				break;
				//Right
				case 39:
						moveRight = true;
						moveLeft = false;
				break; 
				//Down
				case 40:
						mDown = true;
						moveUp = false;
				break;
			}
		}
		
		private function KeyUp(e:KeyboardEvent):void 
		{
			switch(e.keyCode)
			{
				//Left
				case 37:	
					moveLeft = false;
				break;
				//Up
				case 38:
					moveUp = false;
				break;
				//Right
				case 39:
					moveRight = false;
				break; 
				//Down
				case 40:
					mDown = false;
				break;
			}
		}

		private function EnterFrame(event:Event):void 
		{
			//move to the left
			if (moveLeft&&player_.x > 16)
			{
				player_.x -= 10;
			}
			//move to the right
			if (moveRight&&player_.x < 762)
			{
				player_.x +=10;
			}
			// move up
			if (moveUp&&player_.y > 16)
			{
				player_.y -= 10;
			}
			// move down
			if (mDown &&player_.y < 764)
			{
				player_.y +=10;
			}
		}
	}
}