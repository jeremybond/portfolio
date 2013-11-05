package enemies 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Kit van de bunt
	 */
	public class enemieBullit extends Sprite
	{
		[Embed(source = "../files/EnemieBul_png.png")]
		private var Ebul:Class;
		
		private var art:Bitmap = new Ebul;
		public function enemieBullit() 
		{
			addChild(art);
		}
	}

}