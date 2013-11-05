package enemies
{
	import flash.display.MovieClip;
	import enemies.rotationClass;
	/**
	 * ...
	 * @author jeremy & Kit
	 */
	public class bigEnemie extends rotationClass
	{
		public var life:int;
		public var art:MovieClip;
		public function bigEnemie(speedX:int)
		{
			life = 15;
			super(speedX, 1);
			art = new KamikazEenemy();
			addChild(art);
		}
	}
}