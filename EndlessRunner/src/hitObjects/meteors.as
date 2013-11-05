package hitObjects 
{
	import enemies.mediumEnemie;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class meteors extends Sprite
	{
		public var isWholeMeteor:Boolean = true;
		[Embed(source = "../files/metorite v1.png")]
		private var ArtBitmap:Class;
		[Embed(source = "../files/metorite v2.png")]
		private var ArtBitmap2:Class;
		public var RandomRotation:Number = Math.random();
		public function meteors() 
		{
			//pick random rotation direction
			var random:Number = Math.random();
			//pickrandom art
			var art:Bitmap;
			if(random > 0.5){
				art = new ArtBitmap();
				art.x = -191 / 2;
				art.y = -166 / 2;
			}else {
				art = new ArtBitmap2();
				art.x = -119 / 2;
				art.y = -96 / 2;
			}
			addChild(art);
			addChild(art);
		}
		
		//rotate in set direction
		public function loop():void 
		{
			if (RandomRotation < 0.5) 
			{
				this.rotation += RandomRotation;
			}
			if(RandomRotation > 0.5)
			{
				this.rotation -= RandomRotation;
			}
		}
		
	}

}