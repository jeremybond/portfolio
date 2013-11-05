package enemies 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class mediumEnemie extends enemieMove
	{
		public var art:MovieClip;
		public var life:int;
		
		public function mediumEnemie(speed:int) 
		{
			life = 30;
			super(speed);
			art = new FastEnemy();
			addChild(art);
		}
	}

}