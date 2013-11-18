package 
{
	import adobe.utils.CustomActions;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.fscommand;
	import flash.ui.Mouse;
	
	import flash.automation.StageCaptureEvent;
	import flash.display.FocusDirection;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.sampler.NewObjectSample;
	import flash.utils.Timer;
	
	import Player;
	import CreditsScreen;
	import BeginScreen;
	/**
	 * ...
	 * @author kerim birlik && jeremy bond
	 * ...
	 * probeer de main zo leeg mogelijk te houden
	 * ...
	 */
	public class Main extends Sprite 
	{
		//SCREENS
		public             		var score               :int;
		public 					var _startScreen		:BeginScreen 		= new BeginScreen();
		public 					var	_constrolScreen		:ControlsScreen 	= new ControlsScreen();
		public					var _creditsScreen		:CreditsScreen		= new CreditsScreen();
		private					var _loseScreen			:LoseScreen			= new LoseScreen();
		public   static         var ground              :GroundMC           = new GroundMC();
		//STAGE
		public static			var _stage				:Stage;
		//TIMERS
		private             	var scoretimer          :Timer;
		//OTHER OBJECTS	
						[Embed(source="../lib/menuscreenmusic.mp3")]
		private 				var menumusic			:Class;
		private 				var _menumusic			:Sound 				= new menumusic();
		private 				var myChannel			:SoundChannel 		= new SoundChannel();
		private 				var cannon				:Cannon				= new Cannon();
		public static 			var bgph				:background			= new background();
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener	(Event.ADDED_TO_STAGE, 		init);
		}
	  
		private function init(e:Event = null):void 
		{		
			myChannel = _menumusic.play();
			_stage 		= 	stage;
			removeEventListener		(Event.	ADDED_TO_STAGE, 	init);
			addChild				(_startScreen);
			
			_startScreen.addEventListener		(BeginScreen.START, 		startGame);
			_startScreen.addEventListener		(BeginScreen.CREDITS, 		goCredits);
			_startScreen.addEventListener		(BeginScreen.CONTROLS, 		goControls);
			_constrolScreen.addEventListener	(ControlsScreen.BACK,		goToStartScreen1)
			_creditsScreen.addEventListener		(CreditsScreen.BACK, 		goToStartScreen2);
			_loseScreen.addEventListener		(LoseScreen.MENU,			goToStartScreen3);
			addEventListener					(Cannon.DEAD,				addALoseScreen);
		}
		
		
		
		
		
		
		/////////////////////////////////////////////////////////HIER BENEDEN ZITTEN DE KNOPPEN FUNCTIES/////////////////////////////////////////////////////////
		/////////////// van start scherm gewoon BEGINNEN
		private function startGame(e:Event):void
		{
			myChannel.stop();
			cannon.ballTimer.start();
			cannon._battlemusic.play();
			removeChild			(_startScreen);
			score   	=       new int();
			ground.y    =       550;
			addChild			(bgph);//bgph = back ground place holder
			addChild            (ground);
			addChild			(cannon);
		}
		/////////////// van start scherm naar controls scherm
		private function goControls(e:Event):void 
		{
			removeChild(_startScreen);
			addChild(_constrolScreen);
		}
		/////////////// van start scherm naar credits scherm
		private function goCredits(e:Event):void
		{
			removeChild		(_startScreen);
			addChild		(_creditsScreen);
		}
		/////////////// van controls scherm terug naar start scherm
		private function goToStartScreen1(e:Event):void 
		{
			removeChild(_constrolScreen);
			addChild(_startScreen);
		}
		/////////////// van credits scherm terug naar start scherm
		private function goToStartScreen2(e:Event):void 
		{
			removeChild(_creditsScreen);
			addChild(_startScreen);
		}
		/////////////// van lose scherm terug naar start scherm
		private function goToStartScreen3(e:Event):void 
		{
			removeChild(_loseScreen);
			addChild(_startScreen);
		}
		/////////////// van 0 levens naar het lose scherm
		private function addALoseScreen(e:Event):void 
		{
			trace("adding fucknng screen");
			addChild(_loseScreen);
		}
		
		/////////////////////////////////////////////////////////HIER BOVEN ZITTEN DE KNOPPEN FUNCTIES/////////////////////////////////////////////////////////
		private function addingscore(e:Event):void 
		{
			score++;
		}
		
	}
}