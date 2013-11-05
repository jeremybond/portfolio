package game 
{
	import background.PlanetSystem;
	import displayText.PopText;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import game.backgroundEnemie;
	import game.backgroundEnemie;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author Kit van de bunt
	 */
	public class Game extends Sprite
	{
		[Embed(source="../files/background_nebula.png")]
		private var nebulaArt_png:Class;
		
		[Embed(source="../files/Starjedi.ttf", fontFamily = "foo",
		mimeType = "application/x-font",
		fontWeight="normal",
		fontStyle="normal",
		advancedAntiAliasing="true",
		embedAsCFF = "false")]
		public var bar:String;
		
		public var backEnEnemieHolder:backgroundEnemie;
		private var UiBottom:IngameUiArt = new IngameUiArt();
		public var nebula:Bitmap;
		public var player_:MovieClip;
		public static var _game:Game;
		public var playerHealt:int;
		public var playerFuel:Number;
		public var playerShield:Number;
		public var playerHealtStart:int;
		public var playerFuelStart:int;
		public var playerShieldStart:int;
		private var fuelBarFrameToMoveTo:int;
		private var healtBarFrameToMoveTo:int;
		private var shieldBarFrameToMoveTo:int;
		public var display:TextField = new TextField();
		public var displayScore:TextField = new TextField();
		public var displayWeapon:TextField = new TextField();
		private var distance:Number;
		public var weaponType:int;
		public var shieldOnOff:Boolean;
		public var TriAmmo:int = 0;
		public var SprayAmmo:int = 0;
		private var shieldLife:int;
		private var backgroundPlanets:PlanetSystem;
		private var popTextArray:Vector.<PopText> = new Vector.<PopText>;
		
		private var textForm:TextFormat = new TextFormat();
		private var textForm2:TextFormat = new TextFormat();
		
		private var score:int;
		
		public function Game()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_game = this;
			initGame();
		}
		
		private function initGame():void {
			
			//creates the background
			nebula = new nebulaArt_png();
			addChild(nebula);
			
			//creates a planetsystem that moves on a slower y speed than the backEnEnemieHolder
			backgroundPlanets = new PlanetSystem();
			addChild(backgroundPlanets);
			
			//creates a holder for almost everything on the same distance to the viewer(you) as the ship
			backEnEnemieHolder = new backgroundEnemie();
			addChild(backEnEnemieHolder);
			
			//add player
			player_ = new Player();
			player_.scaleX = 0.5;
			player_.scaleY = 0.5;
			player_.x = 70;
			player_.y = stage.stageHeight/2;
			addChild(player_);
			
			//set variables
			distance = 0;
			playerHealt = 20;
			playerHealtStart = playerHealt;
			playerFuel = 100;
			playerFuelStart = playerFuel;
			playerShield = 100;
			playerShieldStart = playerShield;
			healtBarFrameToMoveTo = 100;
			fuelBarFrameToMoveTo = 100;
			shieldBarFrameToMoveTo = 0;
			weaponType = 1;
			shieldOnOff = false;
			shieldLife = 0;
			score = 0;
			
			//ui bottom
			UiBottom.y = stage.stageHeight;
			UiBottom.shieldUI.gotoAndPlay(0);
			UiBottom.lifeUI.gotoAndStop(100);
			UiBottom.fuelUI.gotoAndStop(100);
			addChild(UiBottom);
			
			// set textform display/score
			textForm.font = "foo";
			textForm.size = 36;
			textForm.align = "right";
			display.embedFonts = true;
			display.defaultTextFormat = textForm;
			textForm.align = "left";
			
			// set score display
			displayScore.embedFonts = true;
			displayScore.defaultTextFormat = textForm;
			displayScore.textColor = 0xffffff;
			displayScore.text = "Score: ";
			displayScore.width = 400;
			displayScore.x = 50;
			displayScore.y = 3;
			display.textColor = 0xffffff;
			addChild(displayScore);
			
			// set distance display
			display.text = "display";
			display.width = 600;
			display.x = 550;
			display.y = 3;
			addChild(display);
			
			// set weapon display
			textForm2.font = "foo";
			textForm2.size = 20;
			displayWeapon.embedFonts = true;
			displayWeapon.defaultTextFormat = textForm2;
			displayWeapon.textColor = 0x00eeff;
			displayWeapon.text = "Lazer";
			displayWeapon.x = 565;
			displayWeapon.y = 650;
			displayWeapon.width = 200;
			addChild(displayWeapon);
			
			addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease);
		}
		
		public function endGame():void {
			removeEventListener(Event.ENTER_FRAME, loop);
			if(numChildren!=0){
				var k:int = numChildren;
				while( k -- )
				{
					removeChildAt( k );
				}
			}
		}
		
		public var horUp:int = 0;
		public var horDown:int = 0;
		public var verUp:int = 0;
		public var verDown:int = 0;
		
		private var timerFuel:int = 3;
		private function loop(e:Event):void {
			if (Main.gameStarted) {
				for (var i:int = 0; i < popTextArray.length; i++) 
				{
					if (popTextArray[i].ready) {
						removeChild(popTextArray[i]);
						popTextArray.splice(i , 1);
					}else {
						popTextArray[i].loop();
					}
				}
				//the distance counter
				distance+=0.4;
				//all the backgroundplanets get a loop function
				backgroundPlanets.loop();
				backgroundPlanets.y = (Main.yDisplaysment / 4)-90;
				//move player
				var horMove:int = horUp + horDown;
				var verMove:int = verUp + verDown;
				player_.movePlayer(horMove, verMove);
				//loop doorsture
				backEnEnemieHolder.loop();
				//shieldUI
				if (UiBottom.shieldUI.currentFrame != shieldBarFrameToMoveTo) {
					var deltaMove:int = shieldBarFrameToMoveTo - UiBottom.shieldUI.currentFrame;
					if (deltaMove > 5) {
						deltaMove = 5;
					}
					UiBottom.shieldUI.gotoAndStop(UiBottom.shieldUI.currentFrame+deltaMove);
				}
				
				//lifeUI
				if (UiBottom.lifeUI.currentFrame > healtBarFrameToMoveTo) {
					UiBottom.lifeUI.gotoAndStop(UiBottom.lifeUI.currentFrame-5);
				}else if (UiBottom.lifeUI.currentFrame < healtBarFrameToMoveTo){
					UiBottom.lifeUI.gotoAndStop(UiBottom.lifeUI.currentFrame+5);
				}
				//fuelUI
				timerFuel--;
				if (timerFuel < 0) {
					timerFuel = 3;
					changeFuelBar( -0.4); // can change gameStarted to false!!!
				}
				if (UiBottom.fuelUI.currentFrame > fuelBarFrameToMoveTo) {
					UiBottom.fuelUI.gotoAndStop(UiBottom.fuelUI.currentFrame-1);
				}else if (UiBottom.fuelUI.currentFrame < fuelBarFrameToMoveTo){
					UiBottom.fuelUI.gotoAndStop(UiBottom.fuelUI.currentFrame+1);
				}
				var textdistance:int =  distance;
				var textdistanceString:String = textdistance.toString();
				//the score, meters and lazer displays are updated
				display.text = textdistanceString + " M ";
				displayScore.text = "Score: "+score;
				if (weaponType == 1) {
					displayWeapon.text = "Lazer";
				}else if (weaponType == 2) {
					displayWeapon.text = "Tri Gun: x"+TriAmmo;
				}else if (weaponType == 3) {
					displayWeapon.text = "spray gun: x"+SprayAmmo;
				}
			}
		}
		
		//cheates a popscore(dispay text in game) 
		public function popScore(Deltascore:int, xSpawn:int, ySpawn:int):void {
			score += Deltascore;
			var scoreString:String = Deltascore.toString();
			popTextArray.push(new PopText(scoreString));
			popTextArray[popTextArray.length - 1].x = xSpawn;
			popTextArray[popTextArray.length - 1].y = ySpawn+Main.yDisplaysment;
			addChild(popTextArray[popTextArray.length - 1]);
		}
		
		//lifebarmanager
		public function changeLifeBar(deltaLife:int):void {
			if(!shieldOnOff||deltaLife>0){
				if (playerHealt > 0) {
					playerHealt += deltaLife;
					var frame:int = playerHealt / playerHealtStart * 100;
					healtBarFrameToMoveTo = frame;
				}else {
					Main._main.gameOver(score,distance);
				}
				if (playerHealt >= 100) {
					playerHealt = 100;
					healtBarFrameToMoveTo = 100;
				}
			}else {
				SetShield( -25);
			}
		}
		
		// healt manager
		public function changeFuelBar(deltafFuel:Number):void {
			if (playerFuel > 0) {
				playerFuel += deltafFuel;
				var frame:int = playerFuel / playerFuelStart * 100;
				fuelBarFrameToMoveTo = frame;
			}else {
				Main._main.gameOver(score,distance);
			}
			if (playerFuel >= 100) {
				playerFuel = 100;
			}
		}
		
		// shield manager
		public function SetShield(deltafShield:int = 0):void {
			var frame:int;
			if (deltafShield == 100) {
				setPlayerState(1, NaN);
				playerShield += deltafShield;
			}else {
				playerShield += deltafShield;
			}
			if(playerShield<=0){
				setPlayerState(2, NaN);
				playerShield = 0;
			}else if (playerShield >= 100) {
				playerShield = 100;
			}
			frame = playerShield / playerShieldStart * 100;
			shieldBarFrameToMoveTo = frame;
		}
		
		// hit weaponpack fill ammo
		public function onHitWeaponPack(amount:int = 0, type:int = 0):void {
			if (type == 0) {
				var ran:Number = Math.random();
				type = 1;
				if (ran > 0.5) {
					type = 2;
				}
			}
			switch (type) {
				case 1:
					SprayAmmo += amount;
					break;
				case 2:
					TriAmmo += amount;
					break;
			}
		}
		
		// change player art
		private function setPlayerState(shield:int = NaN, gun:int = NaN):void {
			if (shield) {
				player_.switchArt(shield, NaN);
				if (shield == 1) {
					shieldOnOff = true;
				}else {
					shieldOnOff = false;
				}
			}
			if (gun) {
				player_.switchArt(NaN, gun);
				weaponType = gun;
			}
		}
		
		private function keyPress(event:KeyboardEvent):void {
			switch(event.keyCode) {
			case 87://up
				verUp = -1;
				break;
			case 83://down
				verDown = 1;
				break;
			case 68://right
				horUp = 1;
				break;
			case 65://left
				horDown = -1;
				break;
			}
		}
		
		private function keyRelease(event:KeyboardEvent):void {
			switch(event.keyCode) {
			case 87://up
				verUp = 0;
				break;
			case 83://down
				verDown = 0;
				break;
			case 68://right
				horUp = 0;
				break;
			case 65://left
				horDown = 0;
				break;
			case 49: //weapon switch
				setPlayerState(NaN, 1);
				break;
			case 50: //weapon switch
				setPlayerState(NaN, 2);
				break;
			case 51: //weapon switch
				setPlayerState(NaN, 3);
				break;
			}
		}
	}
}