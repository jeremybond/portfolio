package  
{
	import flash.display.MovieClip;
	import game.Game;
	import test.PointTest;
	/**
	 * ...
	 * @author Kit van de bunt
	 */
	public class Player extends MovieClip
	{
		public var art:MovieClip = new playerArt();
		private var rotationSpeed:Number = 0.8;
		private var maxRotation:int = 12;
		private var maxDistansTop:int = 100;
		private var maxDistansBottom:int = 130;
		private var HitpointsVisible:Boolean = false;
		public var Hitpoints:Vector.<PointTest> = new Vector.<PointTest>;
		public function Player() 
		{
			art.scaleX = 1.5;
			art.scaleY = 1.5;
			addChild(art);
			//stop animation
			art.ShipMC.stop();
			art.ShieldMC.gotoAndStop(2);
			
			//hitpoints
			Hitpoints.push(new PointTest(20, 1,HitpointsVisible));//rechts midden
			Hitpoints.push(new PointTest(25, -45,HitpointsVisible));//rechts boven
			Hitpoints.push(new PointTest(0, 50, HitpointsVisible));//rechts onder
			Hitpoints.push(new PointTest(40, 50,HitpointsVisible));//rechts 2 onder
			Hitpoints.push(new PointTest(40, -40,HitpointsVisible));//rechts 2 boven
			Hitpoints.push(new PointTest(70, 45,HitpointsVisible));//rechts 3 onder
			Hitpoints.push(new PointTest(70, -35,HitpointsVisible));//rechts 3 boven
			Hitpoints.push(new PointTest(100, -20,HitpointsVisible));//midden boven
			Hitpoints.push(new PointTest(95, 32, HitpointsVisible));//midden onder
			Hitpoints.push(new PointTest(120, -20,HitpointsVisible));//midden2 boven
			Hitpoints.push(new PointTest(120, 23,HitpointsVisible));//midden2 onder
			Hitpoints.push(new PointTest(135, -15,HitpointsVisible));//midden4 boven
			Hitpoints.push(new PointTest(135, 23,HitpointsVisible));//midden4 onder
			Hitpoints.push(new PointTest(150, -15,HitpointsVisible));//midden5 boven
			Hitpoints.push(new PointTest(150, 27,HitpointsVisible));//midden5 onder
			Hitpoints.push(new PointTest(170, -10,HitpointsVisible));//midden6 boven
			Hitpoints.push(new PointTest(170, 23,HitpointsVisible));//midden6 onder
			Hitpoints.push(new PointTest(140, 5,HitpointsVisible));//midden
			Hitpoints.push(new PointTest(120, 5,HitpointsVisible));//midden
			Hitpoints.push(new PointTest(100, 5,HitpointsVisible));//midden
			Hitpoints.push(new PointTest(90, 5,HitpointsVisible));//midden
			Hitpoints.push(new PointTest(70, 5,HitpointsVisible));//midden
			
			Hitpoints.push(new PointTest(180, -5,HitpointsVisible));//links boven
			Hitpoints.push(new PointTest(180, 20, HitpointsVisible));//links onder
			Hitpoints.push(new PointTest(190, -4,HitpointsVisible));//links boven
			Hitpoints.push(new PointTest(190, 18, HitpointsVisible));//links onder
			Hitpoints.push(new PointTest(210, -4,HitpointsVisible));//links boven
			Hitpoints.push(new PointTest(210, 18, HitpointsVisible));//links onder
			
			Hitpoints.push(new PointTest(220, 10,HitpointsVisible));//links
			Hitpoints.push(new PointTest(218, -8,HitpointsVisible));//links
			Hitpoints.push(new PointTest(240, 10,HitpointsVisible));//links
			Hitpoints.push(new PointTest(238, 18,HitpointsVisible));//links
			for (var i:int = 0; i < Hitpoints.length; i++) 
			{
				addChild(Hitpoints[i]);
			}
		}
		
		//switch art
		public function switchArt(newShieldFrame:int = NaN, newPlayerframe:int = NaN):void {
			if (newShieldFrame != 0) {
				art.ShieldMC.gotoAndStop(newShieldFrame);
			}
			if (newPlayerframe != 0) {
				art.ShipMC.gotoAndStop(newPlayerframe);
			}
		}
		
		public function movePlayer(horMove:int, verMove:int ):void {
			//movedown
			if(Main.yDisplaysment>-360&&this.y>=stage.stageHeight/2  && verMove > 0){
				Game._game.backEnEnemieHolder.y -= verMove * Main.speedX;
				Main.yDisplaysment -= verMove * Main.speedX;
			}else if (Main.yDisplaysment <= -360 && verMove > 0) {
				if(this.y<stage.stageHeight-maxDistansBottom){
					this.y += verMove * Main.speedX;
				}
			}else if (Main.yDisplaysment > -360 && this.y <= stage.stageHeight / 2  && verMove > 0) {
				if(this.y<stage.stageHeight-maxDistansBottom){
					this.y += verMove * Main.speedX;
				}
			}
			//moveup
			if (Main.yDisplaysment<360&& this.y<=stage.stageHeight/2  && verMove < 0) {
				Game._game.backEnEnemieHolder.y -= verMove * Main.speedX;
				Main.yDisplaysment -= verMove * Main.speedX;
			}else if (Main.yDisplaysment >= 360 && verMove < 0) {
				if(this.y>maxDistansTop){
					this.y += verMove * Main.speedX;
				}
			}else if (Main.yDisplaysment < 360 && this.y >= stage.stageHeight / 2  && verMove < 0) {
				if(this.y>maxDistansTop){
					this.y += verMove * Main.speedX;
				}
			}
			//moveforwarde
			if (this.x > 70 && horMove < 0) {
				this.x += horMove*Main.speedX;
			}
			//movebackwards
			if (this.x < stage.stageWidth -150 && horMove > 0) { 
				this.x += horMove*Main.speedX;
			}
			//rotate up
			if (verMove > 0) {
				if(this.rotation < maxRotation){
					this.rotation += rotationSpeed*2;
				}
			//rotate down
			}else if (verMove < 0) {
				if(this.rotation > -maxRotation){
					this.rotation -= rotationSpeed*2;
				}
			//rotate back to 0
			}else {
				if (this.rotation > rotationSpeed) {
					this.rotation -= rotationSpeed;
				}else if (this.rotation < -rotationSpeed) {
					this.rotation += rotationSpeed;
				}
			}
		}
	}
}