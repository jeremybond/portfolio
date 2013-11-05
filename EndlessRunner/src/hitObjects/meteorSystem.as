package hitObjects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import game.backgroundEnemie;
	import game.Game;
	/**
	 * ...
	 * @author Jeremy Bond & Kit van de Bunt
	 */
	public class meteorSystem extends Sprite
	{
		public var meteoros:Vector.<meteors>;
		public var meteorosParts:Vector.<astroidPart>;
		public var metsCounter:Number;
		public var spawnSpeed:int = 2;
		public function meteorSystem() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			meteoros = new Vector.<meteors>;
			meteorosParts = new Vector.<astroidPart>
			metsCounter = Math.random();
		}
		
		public function loop():void 
		{
			metsCounter --;//spawn timer
			
			if (metsCounter <= 0) 
			{
				//spawn meteor
				metSpawn();
				//reset spawn timer
				switch(spawnSpeed){
					case 0:
						metsCounter = 0;
					break; 
					case 1:
						metsCounter = Math.random() * 10;
					break; 
					case 2:
						metsCounter = Math.random() * 5;
					break;
				}
			}
			else 
			{
				
				for (var i:int = 0; i < meteoros.length; i++) 
				{
					//rotate meteor
					meteoros[i].loop();
					//delete mereor if out of view
					if (meteoros[i].x < -200) 
					{
						removeChild(meteoros[i]);
						meteoros.splice(i, 1);
					}else {
						//move meteor
						meteoros[i].x -= Main.speedX;
					}
				}
				for (var j:int = 0; j < meteorosParts.length; j++) 
				{
					//move meteor in direction
					meteorosParts[j].loop();
					//delete meteor part when life is over
					if (meteorosParts[j].lifeTime < 0) {
						removeChild(meteorosParts[j]);
						meteorosParts.splice(j, 1)
					}else {//move meteor part
						meteorosParts[j].x -= Main.speedX;
					}
				}
			}
		}
		//spawn part group
		public function spawnPart(num:int):void {
			if (meteoros[num].isWholeMeteor) {
				for (var i:int = 0; i < 10; i++) 
				{
					metPartSpawn(meteoros[num].x, meteoros[num].y);
				}
			}
		}
		//remove meteor
		public function removemeteor(o:int):void {
			removeChild(meteoros[o]);
			meteoros.splice(o, 1);
		}
		
		//spawn meteor
		private function metSpawn():void 
		{
			var metWidth:int = Math.random() * 50 + 50;
			meteoros.push(new meteors());
			addChild(meteoros[meteoros.length - 1]);
			meteoros[meteoros.length -1].x = stage.stageWidth + 100;
			meteoros[meteoros.length -1].y = stage.stageHeight*2 * Math.random();
			meteoros[meteoros.length -1].width = metWidth;
			meteoros[meteoros.length -1].height = meteoros[meteoros.length - 1].width;
		}
		//spawn meteor part
		private function metPartSpawn(x:int,y:int):void {
			meteorosParts.push(new astroidPart());
			addChild(meteorosParts[meteorosParts.length - 1]);
			meteorosParts[meteorosParts.length -1].x = x;
			meteorosParts[meteorosParts.length -1].y = y;
			var size:int = Math.random() * 10 + 10;
			meteorosParts[meteorosParts.length -1].width = size;
			meteorosParts[meteorosParts.length -1].height = size;
		}
		
	}
}