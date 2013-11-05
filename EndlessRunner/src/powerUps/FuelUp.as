package powerUps 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import game.Game;
	
	/**
	 * ...
	 * @author Jeremy Bond, etc
	 */
	public class FuelUp extends PowerUpMovement 
	{
		public var art:Sprite;
		public function FuelUp() 
		{
			art = new FeulPack();
			addChild(art);
		}
		public function onHit():void //called on hit player
		{
			// fuel + 25
			Game._game.changeFuelBar( +25);
		}
	}

}