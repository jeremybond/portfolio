package ThePackage
{
	import adobe.utils.CustomActions;
	
	import flash.automation.StageCaptureEvent;
	import flash.display.FocusDirection;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.sampler.NewObjectSample;
	import flash.utils.Timer;
	import flash.system.fscommand;
	
	import ThePackage.BackGroundStuff.Human;
	import ThePackage.BackGroundStuff.HumanFactory;
	import ThePackage.Crap.Crap;
	import ThePackage.Crap.SpaceCrapFactory;
	import ThePackage.Crap.StarCrap;
	import ThePackage.Crap.NormalCrap;
	import ThePackage.PlayerObjects.Bullet;
	import ThePackage.PlayerObjects.Tower;
	import ThePackage.Screens.BeginScreen;
	import ThePackage.Screens.HighScoreSreen;
	
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class Main extends Sprite
	{
		//CLASSES
		[Embed(source="../../Sounds/scream1.mp3")]
		public var _Scream1:Class;
		[Embed(source="../../Sounds/scream2.mp3")]
		public var _Scream2:Class;
		[Embed(source="../../Sounds/scream3.mp3")]
		public var _Scream3:Class;
		[Embed(source="../../Sounds/scream4.mp3")]
		public var _Scream4:Class;
		[Embed(source="../../Sounds/scream5.mp3")]
		public var _Scream5:Class;
		[Embed(source="../../Sounds/scream6.mp3")]
		public var _Scream6:Class;
		[Embed(source="../../Sounds/BackgroundNoise.mp3")]
		public var _Backgroundnoise:Class;
		[Embed(source="../../Sounds/Rockets.mp3")]
		public var _GroundImpact:Class;
		[Embed(source="../../Sounds/inslag.mp3")]
		public var _Hit:Class;
		[Embed(source="../../Sounds/bangbang.mp3")]
		public var _Shot:Class;
		//SOUNDS
		public var _scream1:Sound = new _Scream1();
		public var _scream2:Sound = new _Scream2();
		public var _scream3:Sound = new _Scream3();
		public var _scream4:Sound = new _Scream4();
		public var _scream5:Sound = new _Scream5();
		public var _scream6:Sound = new _Scream6();
		public var _backgroundnoise:Sound = new _Backgroundnoise();
		public var _groundImpact:Sound = new _GroundImpact();
		public var _hit:Sound = new _Hit();
		public var _shot:Sound = new _Shot();
		//ARRAYS
		public static var _allCraps:Array;
		public static var _allHuman:Array = [];
		public static var _allBullets:Array = [];
		//TOWERS
		public var tower1:Tower = new Tower();
		public var tower2:Tower = new Tower();
		public var tower3:Tower = new Tower();
		//NUMBERS
		public var lifes:Number = 1;
		public var TowerChoice:Number;
		public var shootingTowerX:Number;
		public var shootingTowerY:Number;
		//BOOLEANS
		public var gameOn:Boolean = false;
		//INT
		public var score:int;
		//TIMERS
		public var screamTimer:Timer;
		public var timerCrap:Timer;
		public var timerHuman:Timer;
		//FACTORY'S
		private var spaceCrapFactory:SpaceCrapFactory = new SpaceCrapFactory();
		private var humanFactory:HumanFactory = new HumanFactory();
		//SCREEEENS
		public var startScreen:BeginScreen = new BeginScreen();
		public var scoreScreen:HighScoreSreen = new HighScoreSreen();
		public var background:Sprite = new BackgroundArt();
		//BUTTONS
		public var MenuBTN:MenuButtonArt = new MenuButtonArt();
		public var HighBTN:HighScoreBArt = new HighScoreBArt();
		public var ExitBTN:ExitBArt = new ExitBArt();
		
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(startScreen);
			startScreen.x = 400;
			startScreen.y = 300;
			startScreen.addEventListener(BeginScreen.START, startGame);
			startScreen.addEventListener(BeginScreen.SCORE, seeScore);
			startScreen.addEventListener(BeginScreen.FULLSCRN, goFullScreen);
			scoreScreen.addEventListener(HighScoreSreen.BACK, backToStartScreen);
		}
		
		private function goFullScreen(e:Event):void
		{
			if (stage.displayState == StageDisplayState.NORMAL)
			{
				stage.displayState = StageDisplayState.FULL_SCREEN;
					//stage.scaleMode = StageScaleMode.NO_SCALE;
			}
			else
			{
				stage.displayState = StageDisplayState.NORMAL;
			}
		
		}
		
		/////////////////BACK/////////////////
		private function backToStartScreen(e:Event):void
		{
			removeChild(scoreScreen);
			addChild(startScreen);
		}
		
		/////////////////SCORE/////////////////
		private function seeScore(e:Event):void
		{
			removeChild(startScreen);
			addChild(scoreScreen);
		}
		
		/////////////////START/////////////////
		public function startGame(e:Event):void
		{
			lifes = 1;
			_allCraps = [];
			gameOn = true;
			score = 0;
			removeChild(startScreen);
			
			addChild(background)
			addChild(tower1);
			addChild(tower2);
			addChild(tower3);
			
			tower1.x = 200;
			tower2.x = 400;
			tower3.x = 600;
			
			tower1.y = stage.stageHeight - 100;
			tower2.y = stage.stageHeight - 100;
			tower3.y = stage.stageHeight - 100;
			
			screamTimer = new Timer((Math.random() * 1000), 0);
			screamTimer.addEventListener(TimerEvent.TIMER, spawnScreamSound);
			
			timerCrap = new Timer((Math.random() * 2000) + 1000, 0);
			timerCrap.addEventListener(TimerEvent.TIMER, spawnCrap);
			timerCrap.start();
			
			timerHuman = new Timer((Math.random() * 500) + 500, 0);
			timerHuman.addEventListener(TimerEvent.TIMER, spawnHuman);
			timerHuman.start();
			
			stage.addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(MouseEvent.CLICK, mouseClick);
		}
		////////////////////SCREAMSOUNDS////////////////////
		private function spawnScreamSound(e:TimerEvent):void
		{
			if (gameOn)
			{
				var randomScream:int = (Math.random() * 8);
				if (randomScream == 1)
				{
					_scream1.play();
				}
				else if (randomScream == 2)
				{
					_scream2.play();
				}
				else if (randomScream == 3)
				{
					_scream3.play();
				}
				else if (randomScream == 4)
				{
					_scream4.play();
				}
				else if (randomScream == 5)
				{
					_scream5.play();
				}
				else if (randomScream == 6)
				{
					_scream6.play();
				}
			}
		}
		////////////////////SPAWNING HUMANS////////////////////
		private function spawnHuman(e:TimerEvent):void
		{
			var randomHuman:int = Math.random() * 4;
			var newHuman:Human = humanFactory.makeHuman(randomHuman);
			_allHuman.push(newHuman);
			newHuman.x = newHuman.position;
			newHuman.y = stage.stageHeight - 50;
			addChild(newHuman);
			screamTimer.start();
		}
		////////////////////SPAWNING METEOORS////////////////////
		private function spawnCrap(e:TimerEvent):void
		{
			var randomType:Number = (Math.random() * 2);
			var newCrap:Crap = spaceCrapFactory.makeSpaceCrap(randomType);
			_allCraps.push(newCrap);
			newCrap.x = Math.random() * stage.stageWidth;
			newCrap.y = -20;
			addChild(newCrap);
		}
		////////////////////SPAWNING BULLETS////////////////////
		private function mouseClick(e:MouseEvent):void
		{
			if (gameOn)
			{
				var newBullet:Bullet = new Bullet();
				_allBullets.push(newBullet);
				addChild(newBullet);
				
				TowerChoice = Math.random();
				if (TowerChoice > 0.7)
				{
					shootingTowerX = tower1.x;
					shootingTowerY = tower1.y;
					newBullet.rotation = tower1.cannonloop.rotation;
					newBullet.x = tower1.x;
					newBullet.y = tower1.y;
				}
				else if (TowerChoice >= 0.4 && TowerChoice <= 0.7)
				{
					shootingTowerX = tower2.x;
					shootingTowerY = tower2.y;
					newBullet.rotation = tower2.cannonloop.rotation;
					newBullet.x = tower2.x;
					newBullet.y = tower2.y;
				}
				else if (TowerChoice < 0.4)
				{
					shootingTowerX = tower3.x;
					shootingTowerY = tower3.y;
					newBullet.rotation = tower3.cannonloop.rotation;
					newBullet.x = tower3.x;
					newBullet.y = tower3.y;
				}
				var gx:Number = shootingTowerX - mouseX;
				var gy:Number = shootingTowerY - mouseY;
				var RadiansB:Number = Math.atan2(gy, gx);
				var DegreesB:Number = RadiansB * 180 / Math.PI;
				newBullet.movex = Math.cos(RadiansB) * 5;
				newBullet.movey = Math.sin(RadiansB) * 5;
				_shot.play();
			}
		}
		////////////////////LOOP////////////////////
		public function loop(e:Event):void
		{
			if (gameOn)
			{
				score++;
				var ghallghumans:Human;
				var p:int = _allHuman.length;
				for (var n:int = p - 1; n >= 0; n--)
				{
					ghallghumans = _allHuman[n];
					ghallghumans.update();
					if (ghallghumans.x <= -50||ghallghumans.x >= 850)
					   {
					   removeChild(ghallghumans);
					   _allHuman.splice(n, 1);
					}
				}
				/////////////////////////// all bullets get updated and deleted ///////////////////////////
				var bulled:MovieClip;
				var l:int = _allBullets.length;
				for (var i:int = l - 1; i >= 0; i--)
				{
					bulled = _allBullets[i];
					bulled.update();
					if (bulled.x < 0 || bulled.x > stage.stageWidth || bulled.y < 0 || bulled.y > stage.stageHeight)
					{
						removeChild(bulled);
						_allBullets.splice(i, 1);
						bulled = null;
					}
				}
				/////////////////////////// all craps get updated and deleted ///////////////////////////
				var crap:MovieClip;
				var c:int = _allCraps.length;
				for (var k:int = c - 1; k >= 0; k--)
				{
					crap = _allCraps[k];
					_allCraps[k].update();
					if (_allCraps[k].y > stage.stageHeight - 100)
					{
						removeChild(crap);
						_allCraps.splice(k, 1);
						lifes -= 1;
							//_groundImpact.play();
					}
				}
				/////////////////////////// all craps and bullets are destroyed when they collide ///////////////////////////
				l = _allBullets.length;
				c = _allCraps.length;
				for (var j:int = l - 1; j >= 0; j--)
				{
					bulled = _allBullets[j];
					for (var m:int = c - 1; m >= 0; m--)
					{
						crap = _allCraps[m];
						if (bulled && crap && bulled.hitTestObject(crap))
						{
							removeChild(bulled);
							removeChild(crap);
							_allBullets.splice(j, 1);
							_allCraps.splice(m, 1);
							
							break;
						}
					}
				}
				
				/////////////////////////// YOU DIE! ///////////////////////////
				if (lifes <= 0)
				{
					gameOn = false;
					timerHuman.stop();
					timerCrap.stop();
					addChild(MenuBTN);
					addChild(HighBTN);
					addChild(ExitBTN);
					MenuBTN.addEventListener(MouseEvent.CLICK, goToStartScreen);
					HighBTN.addEventListener(MouseEvent.CLICK, goToScoreScreen);
					ExitBTN.addEventListener(MouseEvent.CLICK, exitGame);
					var heightPart:Number = stage.stageHeight / 6;
					MenuBTN.y = heightPart * 1.5;
					HighBTN.y = heightPart * 3;
					ExitBTN.y = heightPart * 4.5;
					var widthPart:Number = stage.stageWidth / 2;
					MenuBTN.x = widthPart;
					HighBTN.x = widthPart;
					ExitBTN.x = widthPart;
				}
			}
		}
		////////////////////REMOVE EVERYTHING FROM THE SCREEN////////////////////
		private function goToStartScreen(e:MouseEvent):void
		{
			removeChild(background)
			removeChild(tower1);
			removeChild(tower2);
			removeChild(tower3);
			removeChild(MenuBTN);
			removeChild(HighBTN);
			removeChild(ExitBTN);
			_allCraps.length = 0;
			addChild(startScreen);
		}
		////////////////////REMOVE EVERYTHING FROM THE SCREEN////////////////////
		private function goToScoreScreen(e:MouseEvent):void
		{
			removeChild(background)
			removeChild(tower1);
			removeChild(tower2);
			removeChild(tower3);
			removeChild(MenuBTN);
			removeChild(HighBTN);
			removeChild(ExitBTN);
			_allCraps.length = 0;
			addChild(scoreScreen);
		
		}
		////////////////////EXIT THE GAME////////////////////
		private function exitGame(e:MouseEvent):void
		{
			fscommand("quit");
		}
	
	}

}
