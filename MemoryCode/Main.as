package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import flash.globalization.CurrencyFormatter;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	
	
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class Main extends Sprite 
	{
		private var sprongkracht:Number;
		private var geland:Boolean;
		private var zwaartekracht:Number;
		private var timer:Timer; // de timer voor het spawnen van sneeuwballen
		private var timer2:Timer; // de timer voor het spawnen van vuurballen
		private var timer3:Timer; // de timer voor het spawnen van kampvuren
		private var timer4:Timer; // de timer die de score laat verhogen
		private var gameOver:Boolean = false;
		private var showRestart:Boolean = false;
		private var startScore:Boolean;
		
		public static var lifebar:Leef;
		public static var ballen:Array;
		public static var vuurBallen:Array;
		public static var vuurKampen:Array;
		
		public var spacePressed:Boolean;
		public var _player:Player;
		public var textveld:TextField;
		public var _ground:GroundArt;
		public var JumpTimer:Timer;
		public var _sky:SkyArt;
		public var _restart:restart;
		public var _score:int;
		
		//public var _lifes:
		
		public static var main:Main;
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event = null):void 
		{
			
			gameOver = false;
			main = this;
			
			//zwaartekracht
			zwaartekracht = 10;
			sprongkracht = 0;
			geland = true;
			
			//achtergrond
			_sky = new SkyArt();
			addChild(_sky);
			_sky.x = -50;
			_sky.y = -50;
			
		
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//achtergrond
			_ground = new GroundArt();
			addChild(_ground);
			_ground.x = 0;
			_ground.y = 350;
			
			//textveld 
			textveld = new TextField();
			addChild(textveld); 
			textScale(textveld, 280, 3);
			//textveld.text = "uw score is " + _score;
			
			startScore = true;
			_score = 0;
			
			//Player neerzetten
			_player = new Player();
			addChild(_player);
			_player.y = 300;
			
			//restart scherm neerzetten
			_restart = new restart();
			addChild(_restart);
			_restart.x = -1000;
			
			// alle losse eventlisteners die ik aanmaak
			addEventListener(Event.ENTER_FRAME, gameloop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, spaceDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, spaceUp);
			
			//dit is een timer voor het neerzetten van een sneeuwbal
			timer = new Timer((Math.random() * 10000), 0);
			timer.addEventListener(TimerEvent.TIMER, spawn);
			timer.start();
			
			//dit is de timer voor het neerzetten van een vuurbal
			timer2 = new Timer((Math.random() * 5000)+4000, 0);
			timer2.addEventListener(TimerEvent.TIMER, spawnVuur);
			timer2.start();
			
			//dit is de timer voor het neerzetten van een kampvuur
			timer3 = new Timer((Math.random() * 5000)+2000, 0);
			timer3.addEventListener(TimerEvent.TIMER, spawnKamp);
			timer3.start();
			
			//dit is de timer voor de score
			timer4 = new Timer(1000);
			timer4.addEventListener(TimerEvent.TIMER, addScore);
			timer4.start();
			
			//hier worden de arrays aangemaakt
			ballen = new Array();
			vuurBallen = new Array();
			vuurKampen = new Array();
			
			//hier worden de hartjes gepositioneerd
			lifebar = new Leef();
			lifebar.x = 20;
			lifebar.y = 20;
			lifebar.updateLife(5);
			addChild(lifebar);
			
		}
		// hier staat wat er gebeurt als timer4 afgelopen is
		private function addScore(e:TimerEvent):void 
		{
			if (timer4.running)
			{
				//hiermee word er steeds punten bij de score toegevoegd
				_score += 1;
			}
		}
		private function textScale(_textveld:TextField, _scaleX:Number = 1, _scaleY:Number = 1):void
		{
			// hier worden de x en y positie van het textveld een bepaalde grootte gegeven
			_textveld.scaleX = _scaleX;
			_textveld.scaleY = _scaleY;
		}
		private function spawn(e:TimerEvent):void 
		{
			// hier worden de sneeuwballen op het beeld gezet
			ballen.push(new Sneeuwbal());
			addChild(ballen[ballen.length - 1]);
		
			timer.delay = Math.random() * 10000;
		}
		private function spawnVuur(e:TimerEvent):void
		{
			// hier worden de vuurballen op het beeld gezet
			vuurBallen.push(new Vuurbal());
			addChild(vuurBallen[vuurBallen.length - 1]);
			
			timer2.delay = (Math.random() * 5000)+4000;
		}
		private function spawnKamp(e:TimerEvent):void
		{
			//hier worden de kampvuren op het beeld gezet
			vuurKampen.push(new Vuurtje());
			addChild(vuurKampen[vuurKampen.length - 1]);
			
			timer3.delay = (Math.random() * 5000)+2000;
		}
		// dit is de gameloop
		private function gameloop(e:Event):void 
		{
			// hier wordt de score in het textveld gezet zodat je het kunt zien
			textveld.text = "Uw score is " + _score;
			
			_player.update();
			// hier staat wat er gebeurt als je dood gaat
			if (gameOver) 
			{
				_score = 0;
				startScore = true;
			}
			// hier worden alle kampvuren ge
			for (var k:int = 0; k < vuurKampen.length; k++) 
			{
				vuurKampen[k].move3();
				
				if (vuurKampen[k].x < -100) 
				{
					removeChild(vuurKampen[k]);
					vuurKampen.splice(k, 1);
				}
			}
			//hier worden de vuurballen op het veld gezet
			for (var j:int = 0; j < vuurBallen.length; j++) 
			{
 				vuurBallen[j].move2();
				
				if (vuurBallen[j].x < -100)
				{
					removeChild(vuurBallen[j]);
					vuurBallen.splice(j, 1);
				}
			}
			// hier worden de sneeuwballen op het veld gezet
			for (var i:int = 0; i < ballen.length; i++) 
			{
				
				ballen[i].move();
				
				if (ballen[i].x < -100) 
				{
					removeChild(ballen[i]);
					ballen.splice(i, 1);
				}
				
			}
			// hier staat wat er gebeurt als je levens op zijn
			if (lifebar.life == 0) 
			{
				startScore = false;
				lifebar.life += 5;
				showRestart = true;
				// hier wordt alles uit de arrays gehaalt
				for (var l:int = ballen.length-1; l >= 0 ; l--) 
				{
					removeChild(ballen[l]);
				}
				for (var m:int = vuurBallen.length-1; m >= 0; m--) 
				{
					removeChild(vuurBallen[m]);
				}
				for (var n:int = vuurKampen.length-1; n >= 0; n--) 
				{
					removeChild(vuurKampen[n]);
				}
				ballen.splice(0,ballen.length);
				vuurBallen.splice(0,vuurBallen.length);
				vuurKampen.splice(0,vuurKampen.length);	
			}
			//hier wordt gezegt wanneer je mag springen
			if (spacePressed && geland)
			{
				sprongkracht = 33;
				geland = false;
			}
			//hier wordt de sprongkracht ongedraait
			if (sprongkracht > -10)
			{
				sprongkracht -= 1;
			}
			// hier worden de 
			_player.y -= sprongkracht;
			_player.y += zwaartekracht;
			// hier wordt de speler op zijn plek gehouden
			if (_player.y >= 300)
			{
				_player.y = 300;
				geland = true;
			}
			// hier staat wat er gebeurt als het startscherm in het midden staat
			if (showRestart)
			{
				_restart.x += 25;
				trace("x", _restart.x);
				if (_restart.x >= 0)// in deze if statement wordt het beeld leeg gemaakt 
				{
					trace("stop");
					showRestart = false;
					gameOver = true;
					clearGame();
					addChild(_restart);
					addChild(textveld);
					textScale(textveld, 5, 3);
					
				}
			}
		}
		// hier worden de items uit de arrays gehaalt en de events worden removed
		private function clearGame():void 
		{
			timer4.removeEventListener(TimerEvent.TIMER, addScore);
			removeEventListener(Event.ENTER_FRAME, gameloop);
			
			for (var i:int = numChildren-1; i >= 0; i--) 
			{
				removeChildAt(i);
			}
		}
		// hier staat wat er gebeurt als je op spatie drukt
		public function spaceUp(e:KeyboardEvent):void
		{  
			if (e.keyCode == 32)
			{
				spacePressed = false;
			}
		}
		// hier staat wat er gebeurt als je spatie los laat
		public function spaceDown(e:KeyboardEvent):void
		{
			if (e.keyCode == 32)
			{
				// hier wordt de init opnieuw gestart als  gameover waar is
				if (gameOver) { 
					init(null);
				}
				else{
					spacePressed = true;
				}
			}	
		}
	}
}	
