package enemies
{
	import enemies.enemieMove;
	import flash.events.Event;
	import game.Game;
	/**
	 * ...
	 * @author Jeremy Bond & kit
	 */
	public class rotationClass extends enemieMove
	{ 
		public var radiansInt:Number = new Number;
		
		//this loop calculates the angel to rotate to the player an rotates to it with a maximum speed of 5degrees per frame
		public function rotationLoop():void { 
			var marge:Number = 600; 
				
			var theX:int = Game._game.player_.x - this.x;
			var theY:int = (Game._game.player_.y - (this.y+Main.yDisplaysment)) * -1;
			var angle:Number = (Math.atan(theY/theX)/(Math.PI/180))-180;
			if (theX<0) {
				angle += 180;
			}
			if (theX>=0 && theY<0) {
				angle += 360;
			}
			var mouseRotation:Number = (angle * -1) + 180;
			var diffrence:Number = this.rotation - (angle * -1) + 180;
			if (diffrence > 180) {
				diffrence= diffrence - 360;
			}
			if (diffrence > 5) {
				this.rotation-=5;
			}else if (diffrence < -5) {
				this.rotation+=5;
			}
				
			radiansInt = this.rotation * (Math.PI / 180);
			var movex:Number = Math.cos(radiansInt) * 7;
			var movey:Number = Math.sin(radiansInt) * 7;
			
			this.x += movex;
			this.y += movey;
		}
		
		//this sets a random rotation
		public function rotationClass(speedX:int, WillItRotate:int = 0) 
		{
			super(speedX)
			this.rotation = (Math.random() * 360);
		}
	}

}
