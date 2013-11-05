package powerUps 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import game.backgroundEnemie;
	import game.Game;
	
	/**
	 * ...
	 * @author Kit
	 */
	public class SchieldBox extends PowerUpMovement 
	{
		public var art:Sprite;
		public function SchieldBox() 
		{
			art = new ShieldPack();
			addChild(art);
		}
		public function onHit():void//called on hit player
		{
			Game._game.SetShield(+100);
		}
	}

}