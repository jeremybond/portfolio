package powerUps 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class PowerUpMovement extends Sprite 
	{
		private var rotate:Number;
		public function PowerUpMovement() 
		{
			//setrandom rotation
			var rand:Number = Math.random() * 2 - 1;
			rotate = Math.random() +1;
			if (rand < 0) {
				rotation * -1;
			}
		}
		
		public function loop():void 
		{
			//move and rotate
			this.x -= 10;
			this.rotation += rotate;
		}
		
	}

}