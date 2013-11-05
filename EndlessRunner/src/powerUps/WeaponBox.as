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
	public class WeaponBox extends PowerUpMovement 
	{
		public var art:Sprite;
		public function WeaponBox() 
		{
			art = new WeaponPack();
			addChild(art);
		}
		public function onHit():void//called on hit player
		{
			//player + 50 random ammo
			Game._game.onHitWeaponPack(50);
		}
	}

}