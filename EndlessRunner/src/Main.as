package 
{
	
	import enemies.bigEnemie;
	import enemies.mediumEnemie;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.utils.Timer;
	import flash.events.MouseEvent;
	import game.Game;
	import flash.media.SoundTransform;
	import game.GameOver;
	import game.soundHolder;
	import game.Splash;
	import game.startScreen;
	
	
	/**
	 * ...
	 * @author Kit van de bunt
	 */
	public class Main extends Sprite 
	{
		public static var SpeedStars:int = 10;
		public var game:Game;
		public var gameOverScreen:GameOver;
		public var Beginscreen:startScreen;
		public var SplasScreen:Splash;
		public var StartScreenSoundLoaded:Boolean = false;
		private var allSound:soundHolder;
		public static var gameWidth:int = 1280;
		public static var gameHeight:int = 720;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			stage.stageFocusRect = false;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_main = this;
			//add Sound class
			allSound = new soundHolder();
			addChild(allSound);
			
			allSound.addEventListener(MouseEvent.CLICK, function():void {
				//focus on game if click sound button
				if (gameStarted) { stage.focus = game; }
			})
			//load menu 
			loadMenu();
		}
		
		public static var speedX:int = 10;
		public static var yDisplaysment:int;
		public static var _main:Main;
		public static var gameStarted:Boolean = false;
		private var onGameOverScreen:Boolean = false;
		
		//load splasscreen
		public function loadSplash():void {
			SplasScreen = new Splash();
			addChild(SplasScreen);
		}
		
		//load game
		public function startGame():void {
			if(StartScreenSoundLoaded){
				soundHolder.sound_.soundchannel.stop();
			}
			soundHolder.sound_.moveSoundKnop(100, 100);
			RemoveAll();
			yDisplaysment = 0;
			game = new Game();
			addChildAt(game,getChildIndex(allSound));
			SpeedStars = 10;
			gameStarted = true;
			soundHolder.sound_.initSound();
			stage.focus = game;
		}
		//load gameover Screen
		public function gameOver(score:int, distance:int):void {
			if (gameStarted) {
				soundHolder.sound_.moveSoundKnop(100, 600);
				gameStarted = false;
				removeChild(game);
				Game._game.endGame();
				soundHolder.sound_.soundchannel.stop();
				gameOverScreen = new GameOver(score,distance);
				addChild(gameOverScreen);
				onGameOverScreen = true;
			}
		}
		//load Menu
		public function loadMenu():void {
			RemoveAll();
			Beginscreen = new startScreen;
			addChildAt(Beginscreen,getChildIndex(allSound));
			loadSplash();
		}
		//remove SpachScreen
		public function RemoveSplash():void {
			if (SplasScreen) {
				removeChild(SplasScreen);
				SplasScreen.removeEventListener(Event.ENTER_FRAME, SplasScreen.loop);
				SplasScreen = null;
				StartScreenSoundLoaded = true;
			}
		}
		//remove All
		private function RemoveAll():void {
            RemoveSplash();
			if (Beginscreen) {
				Beginscreen.StopLoop();
                removeChild(Beginscreen);
                Beginscreen = null;
            }
			if(gameOverScreen)  {    
				removeChild(gameOverScreen);  
				onGameOverScreen = false;
				gameOverScreen = null;
			}
			if(gameOverScreen)  {    
				removeChild(gameOverScreen);  
				onGameOverScreen = false;
				gameOverScreen = null;
			}
		}
	}
}