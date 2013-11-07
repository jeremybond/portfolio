package ThePackage.PlayerObjects 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ThePackage.Crap.NormalCrap;
	import ThePackage.Main;
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class Bullet extends BulletArt
	{
		public var movex : Number;
		public var movey : Number;
		public function Bullet() 
		{
			
		}
		public function update():void
		{
			x -= movex * 5;
			y -= movey * 5;
			
			
		}
	}

}