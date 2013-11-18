package
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.display.Stage;
	import CannonBall;
	/**
	 * ...
	 * @author kerim birlik && jeremy bond
	 */
	public class Player extends MovieClip
	{
		public 		var PDY			:Number;
		public static var player	:PlayerIdleAniMC	= new PlayerIdleAniMC();
	//	private 	var playeridle	:PlayerIdleAniMC 	= new PlayerIdleAniMC();
	//	private     var playerdown  :PlayerDownAniMC    = new PlayerDownAniMC();
	//	private     var playerup    :PlayerUpAniMC	   	= new PlayerUpAniMC();
		private 	var speed		:int 				= new int;
		public function Player() 
		{
			if (stage) init();
			else addEventListener	(Event.ADDED_TO_STAGE, 		init);
		}
	  
		private function init(e:Event = null):void 
		{
			addChild(player);
			player.y = 800 / 2;
			player.gotoAndStop(1);
			
			
			speed = 10;
			stage.addEventListener	(KeyboardEvent.KEY_DOWN, 	KeyPressed);
			stage.addEventListener	(KeyboardEvent.KEY_UP, 		KeyReleased);
			addEventListener		(Event.ENTER_FRAME, 		loop);
		}
		
		public function KeyPressed(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				
				//W
				case 87:
					PDY = -1;
					player.gotoAndStop(3);
				break;
				//  S
				case 83:
					PDY = 1;
					player.gotoAndStop(2);
				break;	
				//Up
				case 38:
					PDY = -1;
					player.gotoAndStop(3);
				break;
				//Down
				case 40:
					PDY = 1;
					player.gotoAndStop(2);
				break;	
			}
		}
		
		public function KeyReleased(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				//  W
				case 87:
					PDY = 0;
					player.gotoAndStop(1);
				break;
				//  S
				case 83:
					PDY = 0;
					player.gotoAndStop(1);
				break;
				//  Up
				case 38:
					PDY = 0;
					player.gotoAndStop(1);
				break;
				//  Down
				case 40:
					PDY = 0;
					player.gotoAndStop(1);
				break;
			}
		}
		
		public function loop (e:Event):void {
			player.y += (PDY * speed);
			
			if (player.y > 480 ) 
			{
				speed = 0;
				player.y -= 20;
			}
			if (player.y < 80) 
			{
				speed = 0;
				player.y += 20;
			}
			else {
				speed = 10;
			}
		}
	}
}

