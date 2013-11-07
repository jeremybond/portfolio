package ThePackage.BackGroundStuff 
{
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.events.PressAndTapGestureEvent;
	import flash.events.Event;
	import ThePackage.Main;
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class Human extends MovieClip
	{
		/*
		*variables
		*/
		public var rotationNumb:Number = Math.random();
		private var _name   : String;
		private var _pos 	: Number;
		private var _speed	: Number;
		private var _left	: Boolean;
		private var _zPos	: Number;
		
		//////////name
		public function get id():String
		{
			return _name;
		}
		public function set id(id:String):void
		{
			_name = id;
		}
		//////////pos
		public function get position():Number
		{
			return _pos;
		}
		public function set position(position:Number):void
		{
			_pos = position;
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
		//////////leftOrRight
		public function get left():Boolean
		{
			return _left;
		}
		public function set left(left:Boolean):void
		{
			_left = left;
		}
		public function get PosZ(): Number
		{
			return _zPos;
		}
		public function set PosZ(PosZ:Number): void
		{
			_zPos = PosZ;
		}
		/*
		*update
		*/
		public function update():void
		{
			//trace("lopen!!!");
			if (_left == true)
			{
				this.x += _speed;
			}else {
				this.x -= _speed;
			}
			
		}
		
	}

}