package game 
{
	import background.PlanetSystem;
	import enemies.enemieBullit;
	import enemies.Kaboem;
	import enemies.bigEnemie;
	import enemies.mediumEnemie;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import hitObjects.meteorSystem;
	import powerUps.FuelUp;
	import powerUps.LifePack;
	import bullits.bullit;
	import powerUps.SchieldBox;
	import powerUps.WeaponBox;
	/**
	 * ...
	 * @author Kit van de bunt, etc
	 * 
	 * this class holds everything on the same distance to the viewer(you) as the ship
	 * 
	 * 
	 * 
	 */
	public class backgroundEnemie extends Sprite
	{
		//create shoot sound
		[Embed(source = "../files/lazer.mp3")]
		private var LazerSound:Class;
		private var lazerSound:Sound = new LazerSound;

		private var yLocation:int = -360;
		private var meteors:meteorSystem;
		
		public var Enemies:Array = new Array();
		public var PowerUps:Array = new Array;
		public var PowerUpSpawnTimer:int = 60;
		public var spawTimer:int;
		public var spawnIncreace:Number = 0;
		
		private var Schooting:Boolean = false;
		private var schootTime:int = 0;
		private var bullets:Array = new Array();
		private var Enemiebullets:Array = new Array();
		public static var distance:int = 0;
		
		public var boemen:Array = new Array();
		
		public function backgroundEnemie() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//add meteorSystem class that holds the meteors
			meteors = new meteorSystem();
			meteors.y = -(stage.stageHeight / 2);
			addChild(meteors);
			
			spawTimer = 0;
			
			stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
		}
		
		//The loop begins here
		public function loop():void {
			if (Main.gameStarted) {
				meteors.loop();
				
				// delete explotions if the animation is done
				for (var l:int = 0; l < boemen.length; l++) {
					if (boemen[l].wegbool) {	
						removeChild(boemen[l]);
						boemen.splice(l, 1);	
					}
				}
				
				//player schoot
				if (schootTime > 0) {
					schootTime--;
				}else{
					if(Schooting){
						Shoot();
					}
				}
				
				//delete player bullit if out of view
				for (var m:int = 0; m < bullets.length; m++) {
					bullets[m].loop();
					if (bullets[m].x > stage.stageWidth + 300) {
						removeChild(bullets[m]);
						bullets.splice(m, 1);
					}
				}
				
				//delete enemy bullet if out of view
				for (var n:int = 0; n < Enemiebullets.length; n++) {
					Enemiebullets[n].x -= 30;
					if (Enemiebullets[n].x < -100) {
						removeChild(Enemiebullets[n]);
						Enemiebullets.splice(n, 1);
						break;
					}
				}
				
				//delete enemie bullit if hit meteor
				for (var s:int = 0; s < Enemiebullets.length; s++) {
					for (var t:int = 0; t < meteors.meteoros.length; t++) 
					{
						if (Enemiebullets[s].hitTestObject(meteors.meteoros[t] )) {
							removeChild(Enemiebullets[s]);
							Enemiebullets.splice(s, 1);
							break;
						}
					}
				}
				
				//on hit powerup
				for (var r:int = 0; r < PowerUps.length; r++) {
					if (PowerUps[r].x < -200) {
						removeChild(PowerUps[r]);
						PowerUps.splice(r, 1);
						break;
					}
					if (PowerUps[r].hitTestObject(Game._game.player_)) {
						PowerUps[r].onHit();
						removeChild(PowerUps[r]);
						PowerUps.splice(r, 1);
					}else {
						PowerUps[r].loop();
					}
				}
				
				for (var j:int = 0; j < Enemies.length; j ++) {
					//Enemies loop
					Enemies[j].loop()
					//enemie rotation loop
					if (Enemies[j] is bigEnemie) { Enemies[j].rotationLoop(); }
					//Enemie shoot 
					if (Enemies[j] is mediumEnemie) 
					{
						var shotvar:Number = Math.random();
						if (shotvar < 0.04) {
							EnemieShoot(j);
						}
					}
					
					
					if(Enemies[j].x < -100 ){//here enemys get deleted when thay are out of view
						removeChild(Enemies[j]);
						Enemies.splice(j, 1);
					}else if (Enemies[j].hitTestObject(Game._game.player_)) {// enemy hittest player
						if (Enemies[j] is bigEnemie) 
						{//explotion
							boemen.push(new Kaboem);
							boemen[boemen.length - 1].x = Enemies[j].x;
							boemen[boemen.length - 1].y = Enemies[j].y;
							addChild(boemen[boemen.length-1]);
						}
						if (Enemies[j] is mediumEnemie) 
						{//small explotion
							boemen.push(new Kaboem);
							boemen[boemen.length - 1].x = Enemies[j].x - 100;
							boemen[boemen.length - 1].y = Enemies[j].y;
							boemen[boemen.length - 1].width *= 0.4;
							boemen[boemen.length - 1].height *= 0.4;
							addChild(boemen[boemen.length-1]);
						}
						//remove enemy
						removeChild(Enemies[j]);
						Enemies.splice(j, 1);
						// player life -1
						Game._game.changeLifeBar( -1);
					}else{
						for (var k:int = 0; k < bullets.length; k++) {//player bullit hittest with enemy
							if (bullets[k].hitTestObject(Enemies[j])) {
								removeChild(bullets[k]);
								bullets.splice(k, 1);
								
								Enemies[j].life-=5;
								if (Enemies[j].life < 0) { // delete enemy if has no more life
									//create score text
									Game._game.popScore(50, Enemies[j].x, Enemies[j].y);
									//create explotion
									boemen.push(new Kaboem);
									boemen[boemen.length - 1].x = Enemies[j].x;
									boemen[boemen.length - 1].y = Enemies[j].y;
									addChild(boemen[boemen.length - 1]);
									//delete enemy
									removeChild(Enemies[j]);
									Enemies.splice(j, 1);
									break;
								}
								break;
							}
						}
					}
				}
				//enemy bullet hittest with player
				for (var q:int = 0; q < Enemiebullets.length; q++) {
					if (Enemiebullets[q].hitTestObject(Game._game.player_)) {
						Game._game.changeLifeBar( -1);
						removeChild(Enemiebullets[q]);
						Enemiebullets.splice(q, 1);
					}
				}
				
				for (var o:int = 0; o < meteors.meteoros.length; o ++) {
					for (var i:int = 0; i < Game._game.player_.Hitpoints.length; i++) {
						//hittest meteors with player
						if (Game._game.player_.Hitpoints[i].hitTestObject(meteors.meteoros[o]))  {
							meteors.removemeteor(o);
							Game._game.changeLifeBar( -1);
						}
					}
					
					for (var p:int = 0; p < bullets.length; p++) {
						//hittest meteors with player bullits
						if (bullets[p].hitTestObject(meteors.meteoros[o])) {
							meteors.spawnPart(o);
							meteors.removemeteor(o);
							removeChild(bullets[p]);
							bullets.splice(p, 1);
							break;
						}
					}
				}
				
				
				
				// enemy spawner
				spawTimer --;
				
				// powerup spawn timer
				PowerUpSpawnTimer --;
				if (PowerUpSpawnTimer <= 0)
				{//powerup spawn
					newPowerUp(Math.random() * 1200+150 , 200);
					var randomSpawnNumber:int =  Math.random() * 60 + 30;
					PowerUpSpawnTimer = randomSpawnNumber;
				}
				
				if (spawTimer < 0)
				{
					var random:int = Math.random() * 2;
					//spawn function
					switch(random) {
						case 0:
							spawnenemieGroup2();
							spawTimer = 12.8 * (10 - spawnIncreace);
						break;
						case 1:
							spawnenemieGroup3();
							spawTimer = 12.8 * (10 - spawnIncreace);
						break;
						// the higher the distance gets, the higher the spawnIncreace is getting, and the faster the enemy's spawn 
						if (distance >= 200) 
						{
							spawnIncreace += 0.5;
						}else if (distance >= 400)
						{
							spawnIncreace += 1.0;
						}else if (distance >= 800)
						{
							spawnIncreace += 1.5;
						}else if (distance >= 1500)
						{
							spawnIncreace += 2.5;
						}else if (distance >= 4000)
						{
							spawnIncreace += 4;
						}else if (distance >= 9000)
						{
							spawnIncreace += 6;
						}else {
							spawnIncreace += 0.035;
						}
					}
				}
			}
		}
		//end of loop
		
		// this function creates a new random powerUp
		private function newPowerUp(ypos:int, xpos:int):void
		{
			var random2:Number = Math.random()*1.5;
			if(random2 < 0.40){
				PowerUps.push(new LifePack());
			}else if (random2 >= 0.40 && random2 < 0.90){
				PowerUps.push(new FuelUp());
			}else if(random2>=0.9 && random2 < 1.20) {
				PowerUps.push(new SchieldBox());
			}else {
				PowerUps.push(new WeaponBox());
			}
			PowerUps[PowerUps.length - 1].x = xpos + Main.gameWidth;
			PowerUps[PowerUps.length - 1].y = ypos + (yLocation + (Main.gameHeight / 2) - 384);
			addChild(PowerUps[PowerUps.length - 1]);
		}
		
		// this function creates a new group of medium enemys
		private function spawnenemieGroup2():void {
			var height:int = (stage.stageHeight*2) / 6;
			newMediumEnemie(height*1,50);
			newMediumEnemie(height*2,100);
			newMediumEnemie(height*3,150);
			newMediumEnemie(height*4,100);
			newMediumEnemie(height*5,50);
		}
		
		// this function creates a new group of big enemys
		private function spawnenemieGroup3():void {
			var height:int = (stage.stageHeight*2) / 4;
			newBigEnemie(height * 1,Math.random()*400);
			newBigEnemie(height * 2,Math.random()*400);
			newBigEnemie(height * 3,Math.random()*400);
		}
		
		//this function creates a medium enemy
		private function newMediumEnemie(ypos:int, xpos:int):void {
			Enemies.push(new mediumEnemie(Main.speedX));
			Enemies[Enemies.length - 1].x = xpos+stage.stageWidth;
			Enemies[Enemies.length - 1].y = ypos+(yLocation+(parent.stage.stageHeight/2)-384);
			addChild(Enemies[Enemies.length - 1]);
		}
		
		//this function creates a big enemy
		private function newBigEnemie(ypos:int, xpos:int):void {
			Enemies.push(new bigEnemie(Main.speedX));
			Enemies[Enemies.length - 1].x = xpos+stage.stageWidth;
			Enemies[Enemies.length - 1].y = ypos+(yLocation+(parent.stage.stageHeight/2)-384);
			addChild(Enemies[Enemies.length - 1]);
		}
		
		// player shoot function
		private function Shoot():void {
			var AmmoCheck:Boolean = true;
			//ammo check if there is ammo decrese ammo 
			switch(Game._game.weaponType) {
			case 2:
				if (Game._game.TriAmmo <= 0) {
					AmmoCheck = false;
				}else {
					Game._game.TriAmmo--;
				}
				break;
			case 3:
				if (Game._game.SprayAmmo <= 0) {
					AmmoCheck = false;
				}else {
					Game._game.SprayAmmo--;
				}
				break;
			}
			
			//player shoot
			if (AmmoCheck) {
				if(soundHolder.sound_.soundOnOff){
					lazerSound.play();
				}
				switch(Game._game.weaponType) {
				case 1:
					newBullit();
					schootTime = 5;
					break;
				case 2:
					newBullit();
					newBullit(15);
					newBullit( -15);
					schootTime = 12;
					Game._game.TriAmmo--;
					break;
				case 3:			
					newBullit(Math.random()*40-20,2);
					newBullit(Math.random()*40-20,2);
					newBullit(Math.random()*40-20,2);
					newBullit(Math.random() * 40 - 20, 2);
					schootTime = 1;
					Game._game.SprayAmmo--;
					break;
				}
			}
		}
		
		//new player bullit
		private function newBullit(rotate:int = 0, type:int = 1):void {
			bullets.push(new bullit(rotate, type));
			var rot:Number = Game._game.player_.rotation;
			var xDisplaysment:Number = 120 * Math.cos(rot * Math.PI / 180);
			var yDisplaysment:Number = 7+120 * Math.sin(rot * Math.PI / 180);
			bullets[bullets.length - 1].x = Game._game.player_.x+xDisplaysment;
			bullets[bullets.length - 1].y = Game._game.player_.y-Main.yDisplaysment+yDisplaysment;
			addChild(bullets[bullets.length - 1]);
		}
		
		//new enemy bullit
		private function EnemieShoot(enemieNum:int):void {
			Enemiebullets.push(new enemieBullit());
			Enemiebullets[Enemiebullets.length - 1].x = Enemies[enemieNum].x;
			Enemiebullets[Enemiebullets.length - 1].y = Enemies[enemieNum].y+20;
			addChild(Enemiebullets[Enemiebullets.length - 1]);
		}
		
		// shooting key check
		private function keyRelease(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case 32:
					Schooting = false;
				break;
			}
		}
		private function keyPress(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case 32:
					Schooting = true;
				break;
			}
		}
	}
}