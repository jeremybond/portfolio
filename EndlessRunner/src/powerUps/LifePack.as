package powerUps
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import game.Game;
	
	/**
	 * ...
	 * @author Jeremy Bond, etc
	 */
	public class LifePack extends PowerUpMovement 
	{
		public var art:Sprite;
		public function LifePack() 
		{
			art = new HealtPack();
			addChild(art);
		}
		public function onHit():void//called on hit player
		{
			//player life +5
			Game._game.changeLifeBar( +5);
		}
		
	}

}