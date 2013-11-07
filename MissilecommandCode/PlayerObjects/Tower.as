package ThePackage.PlayerObjects 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class Tower extends WholeCannonArt
	{
		public static var _allTowers:Array = [];
		//public var _cannon:WholeCannon = new WholeCannon();
		public function Tower() 
		{
			_allTowers.push(this);
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void 
		{
			var cx:Number = mouseX - cannonloop.x;
			var cy:Number = mouseY - cannonloop.y;
			
			//var RadiansM:Number = Math.atan2(my, mx);
			var Radians:Number = Math.atan2(cy, cx); 
			
			//var DegreesM:Number = RadiansM * 180 / Math.PI;
			var Degrees:Number = Radians * 180 / Math.PI;
			
			cannonloop.rotation = Degrees+90;
		}
		
	}

}