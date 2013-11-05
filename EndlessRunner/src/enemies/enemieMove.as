package enemies 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Kit van de bunt
	 */
	public class enemieMove extends MovieClip
	{
		private var thisSpeed:int;
		public function enemieMove(speed:int =3) //speed will be 3 exept if extending class gives argument with super(speed)
		{
			thisSpeed = speed;
		}
		
		public function loop():void {
			this.x -= thisSpeed;
		}
	}

}