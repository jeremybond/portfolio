package game 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author Kit van de bunt
	 */
	public class soundHolder extends Sprite
	{
		
		
		[Embed(source="../files/endless-runner.mp3")]
		private var gameSound:Class;
		
		[Embed(source="../files/space theme intro.mp3")]
		private var menuSound:Class;
		
		public var Music:Sound;
		public var soundchannel:SoundChannel;
		public var soundOnOff:Boolean = true;
		public var soundButton:MuteButton = new MuteButton;
		
		public static var sound_:soundHolder;
		public function soundHolder() 
		{
			sound_ = this;
			
			//create sound button
			addChild(soundButton);
			soundButton.x = 100;
			soundButton.y = 600;
			soundButton.MuteKnop.stop();
			soundButton.MuteKnop.addEventListener(MouseEvent.CLICK, MuteSwitch);
		}
		
		//sound on off switch
		public function MuteSwitch(e:MouseEvent):void 
		{
			if(soundchannel.soundTransform.volume > 0)
			{
				mute();
			}else
			{
				unMute();
			}
		}
		//mute
		private function mute():void { 
			var st:SoundTransform = new SoundTransform();
			st.volume = 0;
			soundButton.MuteKnop.gotoAndStop(4);
			soundOnOff = false;
			soundchannel.soundTransform = st;
		}
		//unmute
		private function unMute():void { 
			var st:SoundTransform = new SoundTransform();
			st.volume = 1;
			soundButton.MuteKnop.gotoAndStop(1);
			soundOnOff = true;
			soundchannel.soundTransform = st;
		}
		// ingamesound
		public function initSound():void {
			Music = new gameSound();
			soundchannel = Music.play();
			soundchannel.addEventListener(Event.SOUND_COMPLETE, reInitSound1);
			if(!soundOnOff){
				mute();
			}
		}
		//menu sound
		public function initSound2():void {
			Music = new menuSound();
			soundchannel = Music.play();
			soundchannel.addEventListener(Event.SOUND_COMPLETE, reInitSound2);
			if(!soundOnOff){
				mute();
			}
		}
		//recreate gamesound
		private function reInitSound1(e:Event):void {
			Music = new gameSound();
			soundchannel = Music.play();
			soundchannel.addEventListener(Event.SOUND_COMPLETE, reInitSound1);
			if (!soundOnOff) {
				mute();
			}
		}
		//recreate menu sound
		private function reInitSound2(e:Event):void {
			Music = new menuSound();
			soundchannel = Music.play();
			soundchannel.addEventListener(Event.SOUND_COMPLETE, reInitSound2);
			if (!soundOnOff) {
				mute();
			}
		}
		
		//public function to move sound button(needed wen switching berween game en menu)
		public function moveSoundKnop(x:int,y:int):void {
			soundButton.x = x;
			soundButton.y = y;
		}
	}
}