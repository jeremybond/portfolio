package bullits
{
	/**
	 * ...
	 * @author Kit van de bunt
	 */
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import game.Game;
	public class bullit extends Sprite
	{
		[Embed(source = "../files/bullit.png")]
		private var bullitRound:Class
		private var art:Sprite;
		private var bitArt:Bitmap
		private var ThisRotation:int;
		
		//creates billit off specified type
		public function bullit(rotation:int = 0,type:int =1) 
		{
			ThisRotation = rotation + Game._game.player_.rotation;
			this.rotation = ThisRotation+0.01 ; //without the plus 0.01 to bullits on 0 degrees are not visible 
			if(type==1){
				art = new lazerArt();
				addChild(art);
			}else {
				bitArt = new bullitRound();
				bitArt.x = -8;
				bitArt.y = -8;
				addChild(bitArt);
			}
		}
		
		//move nullit forward in rotated direction
		public function loop():void {
			var speed:int = 20;
			var moveX:Number =  Math.sin(this.rotation* Math.PI / 180) * speed;
			var moveY:Number = Math.cos(this.rotation* Math.PI / 180) * speed;
			this.y +=  moveX;
			this.x +=  moveY;
		}
	}

}