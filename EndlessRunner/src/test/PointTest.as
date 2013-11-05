package test 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Kit van de bunt
	 */
	public class PointTest extends Sprite
	{
		//create point for hittesting
		public function PointTest(xpos:int=0,ypos:int=0 ,draw:Boolean =true) 
		{
			var opasity:Number = 0;
			this.x = xpos;
			this.y = ypos;
			if(draw){
				opasity = 1;
			}
			this.graphics.lineStyle(0,0x000000,opasity);
			this.graphics.beginFill(0xffffff,opasity);
			this.graphics.drawCircle(0, 0, 4);
		}
		
	}

}