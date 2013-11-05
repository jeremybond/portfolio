package game 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class startScreen extends Sprite
	{
		private var mainMenu:mainMenuMC;
		public var removeInscructions:Boolean = true;
		public var removeCredits:Boolean = true;
		public var buttonDown:Boolean = false;
		public var instructionsDisplay:instrucScreen;
		public var creditsDisplay:creditsScreen2;
		public function startScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void {
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			mainMenu = new mainMenuMC;
			addChild(mainMenu);
			//new instruction screen
			instructionsDisplay = new instrucScreen();
			instructionsDisplay.x = -1300;
			instructionsDisplay.y = 25;
			addChild(instructionsDisplay);
			//new creditscreenw
			creditsDisplay = new creditsScreen2();
			creditsDisplay.x = stage.stageWidth + 20;
			creditsDisplay.y = 70
			addChild(creditsDisplay);
			
			//add button aventlisteners
			mainMenu.instructionsButton.addEventListener(MouseEvent.CLICK, instrButtonClick);
			mainMenu.creditsButton.addEventListener(MouseEvent.CLICK, creditsButtonClick);
			mainMenu.startButton.addEventListener(MouseEvent.CLICK, startButtonClick);
			instructionsDisplay.RedButton.addEventListener(MouseEvent.CLICK, instrExitClick);
			creditsDisplay.RedButton.addEventListener(MouseEvent.CLICK, crdExitClick);
			//add enter frame loop
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		//button functoins
		private function creditsButtonClick(e:MouseEvent):void { removeCredits = false };
		private function instrExitClick(e:MouseEvent):void { removeInscructions = true };
		private function crdExitClick(e:MouseEvent):void { removeCredits = true };
		private function instrButtonClick(e:MouseEvent):void { removeInscructions = false };
		private function startButtonClick(e:MouseEvent):void { Main._main.startGame() };
		
		public function loop(e:Event):void 
		{
			//move instructions
			if(removeInscructions == false){
				if (instructionsDisplay.x  <= -150) //on
				{
					instructionsDisplay.x += 40;
					if (!removeCredits) {
						removeCredits = true;
					}
				}
			}
			if (removeInscructions)
			{
				if (instructionsDisplay.x >= -1300) //off
				{
					instructionsDisplay.x -= 40;
				}
			}
			//move credits
			if(!removeCredits){
				if (creditsDisplay.x  >= stage.stageWidth -700) //on
				{
					creditsDisplay.x -= 25;
					if (!removeInscructions) {
						removeInscructions = true;
					}
				}
			}
			if (removeCredits)
			{
				if (creditsDisplay.x <= stage.stageWidth + 20) //off
				{
					creditsDisplay.x += 25;
				}
			}
			
		}
		// This function is called from Main when te startscreen is deleted
		public function StopLoop():void {
			removeEventListener(Event.ENTER_FRAME, loop);
		}
	}

}