package hitObjects 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Kit van de bunt
	 */
	public class astroidPart extends Sprite
	{
		public var isWholeMeteor:Boolean = false;
		[Embed(source="../files/part1.png")]
		private var astroid_png:Class;
		[Embed(source="../files/part2.png")]
		private var astroid_png2:Class;
		
		private var art:Bitmap;
		private var direction:int = Math.random()*360;
		private var RandomRotation:Number = Math.random();
		private var Xspeed:Number;
		private var Yspeed:Number;
		private var speed:Number = Math.random() * 5 + 3;
		public var lifeTime:int = Math.random() * 70 + 70;
		
		//create astroid part
		public function astroidPart() 
		{
			//movement direction
			Xspeed = Math.cos(direction);
			Yspeed = Math.sin(direction);
			//pick random art
			var random:Number = Math.random();
			if(random > 0.5){
				art = new astroid_png();
			}else {
				art = new astroid_png2();
			}
			addChild(art);
		}
		
		//move astroid in set direction
		public function loop():void 
		{
			lifeTime--;
			if(speed>0){
				this.x += Xspeed * speed;
				this.y += Yspeed * speed;
				speed-=0.05;
			}
		}
	}

}