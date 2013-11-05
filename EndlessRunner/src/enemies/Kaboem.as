package enemies  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import game.backgroundEnemie;
	import flash.events.Event;
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class Kaboem extends Sprite
	{
		private var art:MovieClip;
		public var wegbool:Boolean = false;
		public function Kaboem() 
		{ 
			art = new explode();
			addChild(art);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void 
		{
			if (art.currentFrame == art.totalFrames) 
			{
				wegbool = true;
			}
		}
		
	}

}