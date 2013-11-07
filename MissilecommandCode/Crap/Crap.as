package ThePackage.Crap 
{
	import flash.display.MovieClip;
	import flash.events.PressAndTapGestureEvent;
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class Crap extends MovieClip
	{
		/*
		*variables
		*/
		public var rotationNumb:Number = Math.random();
		private var _id   	: String;
		private var _splice : Boolean;
		private var _damage : Number;
		private var _speed	: Number;
		
		//////////name
		public function get id():String
		{
			return _id;
		}
		public function set id(id:String):void
		{
			_id = id;
		}
		//////////splice
		public function get splice():Boolean
		{
			return _splice;
		}
		public function set splice(splice:Boolean):void
		{
			_splice = splice;
		}
		//////////damage
		public function get damage(): Number
		{
			return _damage;
		}
		public function set damage(damage:Number):void
		{
			_damage = damage;
		}
		//////////speed
		public function get speed(): Number
		{
			return _speed;
		}
		public function set speed(speed:Number): void
		{
			_speed = speed;
		}
		/*
		*update
		*/
		public function update():void
		{
			if (rotationNumb < 0.5) rotation ++;
			if (rotationNumb > 0.5) rotation --;
			y += speed;
		}
		
	}

}