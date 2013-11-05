package game 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.KeyboardEvent;
	import flash.net.URLRequestMethod;
	import flash.text.Font;
	/**
	 * ...
	 * @author Kit van de bunt
	 * 
	 * I didn't create the clickSub function it is a copy of hugos function from the boilerplate that he gave us.
	 */
	public class GameOver extends Sprite
	{
		private var gameScore:int;
		private var gameDistance:int;
		private var totalInt:int;
		private var submitTicker:Boolean = true;
		private var submitBox:TextField;
		private var gameOver:MovieClip = new gameoverscherm();
		private var format:TextFormat = new TextFormat();
		
		[Embed(source="../files/Starjedi.ttf", fontFamily = "foo",
		mimeType = "application/x-font",
		fontWeight="normal",
		fontStyle="normal",
		advancedAntiAliasing="true",
		embedAsCFF = "false")]
		public var bar:String;
		
		[Embed(source="../files/explosion_gameover.mp3")]
		private var deathsound:Class;
		
		public function GameOver(score:int = -777, distance:int = -777) {
			addEventListener(Event.ADDED_TO_STAGE, init);
			//set font
			format.size = 24;
			format.font = "foo";
			format.color = 0xcc0000;
			format.align = "center";
			//set score, point en distance variables
			gameDistance = distance;
			gameScore = score;
			totalInt = score + distance;
			
			// game over soun explotion
			addChild(gameOver);
			if (soundHolder.sound_.soundOnOff) {
				var deathsound:Sound = new deathsound;
				deathsound.play();
			}
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		//removes alle eventlistener bevore exitting
		private function Exit():void {
			gameOver.RetryButton.addEventListener(MouseEvent.CLICK, startGame );//restart
			gameOver.SubButton.removeEventListener(MouseEvent.CLICK, clickSub);//submit
			gameOver.MenuButton.removeEventListener(MouseEvent.CLICK, loadMenu );//menu
		}
		
		private function loop(e:Event):void {
			if (gameOver.currentFrame == 58) {
				removeEventListener(Event.ENTER_FRAME, loop);
				gameOver.RetryButton.addEventListener(MouseEvent.CLICK, startGame );//restart
				gameOver.SubButton.addEventListener(MouseEvent.CLICK, clickSub);//submit
				gameOver.MenuButton.addEventListener(MouseEvent.CLICK, loadMenu );//menu
				var disanceTXT:String = gameDistance.toString();
				var scoreTXT:String = gameScore.toString();
				var totalTXT:String = totalInt.toString();
				// create distancefield
				var DistanceField:TextField = new TextField();
				DistanceField.defaultTextFormat = format;
				DistanceField.embedFonts = true;
				DistanceField.x = 400;
				DistanceField.y = 290;
				DistanceField.width = 440;
				DistanceField.height = 42;
				DistanceField.text = "Distance: " + disanceTXT;
				addChild(DistanceField)
				// create pointsfield
				var Points:TextField = new TextField();
				Points.defaultTextFormat = format;
				Points.embedFonts = true;
				Points.x = 400;
				Points.y = 347;
				Points.width = 440;
				Points.height = 42;
				Points.text = "Points : " + scoreTXT;
				addChild(Points)
				// create scorefield
				var ScoreField:TextField = new TextField();
				ScoreField.defaultTextFormat = format;
				ScoreField.embedFonts = true;
				ScoreField.x = 400;
				ScoreField.y = 405;
				ScoreField.width = 440;
				ScoreField.height = 42;
				ScoreField.text = "Total Score: " + totalTXT;
				addChild(ScoreField)
				// create submitbox
				submitBox = new TextField();
				submitBox.defaultTextFormat = format;
				submitBox.embedFonts = true;
				submitBox.width = 339;
				submitBox.height = 42;
				submitBox.x = 452;
				submitBox.y = 206;
				submitBox.type = "input";
				submitBox.maxChars = 20;
				addChild(submitBox);
				stage.focus = submitBox;
			}
		}
		// restart
		private function startGame(e:MouseEvent):void {
			Exit();
			Main._main.startGame();
		}
		// load menu
		private function loadMenu(e:MouseEvent):void {
			Exit();
			Main._main.loadMenu();
		}
		
		//submitscore
		private function clickSub(e:MouseEvent):void {
				if (submitTicker) {
					submitTicker = false;
					// url variablen object maken om de get variableen mee te geven
					var variables:URLVariables = new URLVariables();
					// stel de gebruiker "hard" in op 1
					variables.userid = submitBox.text;
					// lees de scores uit het score tekstveld
					variables.score = totalInt;
					
					// een http verzoek tot pagina opvragen aanmaken
					var request:URLRequest = new URLRequest();
					// url naar de score pagina aangeven (relatief of absoluut)
					request.url = "http://15252.hosts.ma-cloud.nl/test/eigen/endlessRunner/score.php";
					// geef aan dat de variablen in de url worden meegegeven (itt post)
					request.method = URLRequestMethod.GET;
					// url variabelen meegeven aan het verzoek
					request.data = variables;
					// laad object maken om het verzoek echt te versturen en "in te laden"
					var loader:URLLoader = new URLLoader();
					// data formaat instellen op "variabelen"
					// loader.dataFormat = URLLoaderDataFormat.VARIABLES;
					// aangeven welek functie moet worden uitgevoord als de data is ingelezen
					loader.addEventListener(Event.COMPLETE, loadingReady);
					loader.load(request);
			}
		}
		
		private function loadingReady(event:Event):void {
			var scorelist:XML = new XML(event.target.data);
			trace(scorelist.user.(@rank == 1));
		}
	}
}