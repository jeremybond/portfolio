package Level
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import Level.Lvls;
	import Player.Player;
	
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class TileSystem extends Sprite
	{
		private 		var 	changeLevelBool	:Boolean = true;
		private			var 	_alltiles		:Array = [];
		private 		var 	_allTilesID		:Array = [];
		private			var 	lvlCounter		:int = 1;
		private			var 	Xpos			:int = 0;
		private			var 	Ypos			:int = 0;
		private			var 	at				:int = 0;
		private			var 	aat				:int = 0;
		private			var 	tile			:MovieClip = new MovieClip();
		public 			var 	allLevels		:Lvls = new Lvls();
		public 			var 	player			:Player.Player = new Player.Player();
		private			var		playerEnterPos	:Point;
		private 		var 	ground			:ground_MC = new ground_MC();
		
		
		public function TileSystem()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//ADDING GROUND
			addChild(ground);
			//ADDING FIRST LVL
			pushTileInArray();
			//PLAYER STUFF
			addChild(player);
			//EVENTLISTENERS
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
		{
			at = _alltiles.length - 1;
			aat = (at * -1) + 625;
		}
		
		private function keyUp(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case 40:
					changeLevelBool = false;
					break;
				case 39:
					changeLevelBool = false;
					break;
				case 38:
					changeLevelBool = false;
					break;
				case 37:
					changeLevelBool = false;
					break;
			
			}
		}
		
		private function KeyDown(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case 40: //ga een level naar onderen
					if (player.player_.y >752) 
					{
						if (lvlCounter < 7)
						{
							player.player_.y -= 732;
							changeLevelBool = true;
							lvlCounter += 3;
							changeStuff();
						}
					}
				break;
				case 39: //ga een level naar rechts
					if (player.player_.x > 752) 
					{
						if (lvlCounter < 9)
						{
							player.player_.x -= 732;
							changeLevelBool = true;
							lvlCounter += 1;
							changeStuff();
						}
					}
				break;
				case 38: //ga een level naar boven
					if (player.player_.y < 16) 
					{
						if (lvlCounter > 3)
						{
							player.player_.y += 732;
							changeLevelBool = true;
							lvlCounter -= 3;
							changeStuff();
						}
					}
				break;
				case 37: //ga een level naar links
					if (player.player_.x < 16) 
					{
						if (lvlCounter > 1)
						{
							player.player_.x += 732;
							changeLevelBool = true;
							lvlCounter -= 1;
							changeStuff();
						}
					}
				break;
			}
		
		}
		
		private function changeStuff():void
		{				
			Xpos = 0;
			Ypos = 0;
			for (var i:int = at; i >= 0; i--)
			{
				_alltiles.splice(i, 1);
				removeChildAt(stage.numChildren);
			}
			removeChild(player);
			pushTileInArray();
			addChild(player);
		}
		
		private function pushTileInArray():void
		{
			for (var i:int = -1; i < 625; i++)
			{
				chooseArray(i);
				
				if (Xpos > 24)
				{
					Ypos++;
					Xpos = 0;
				}
				Xpos++;
			}
		}
		////Taking the tiles from an lvl array and adding the specific tile to the stage array
		public function chooseArray(i:int):void
		{
			if (changeLevelBool)
			{
				switch (lvlCounter)
				{
					case 1: 
						addTile(Lvls.part1[i]);
						break;
					case 2: 
						addTile(Lvls.part2[i]);
						break;
					case 3: 
						addTile(Lvls.part3[i]);
						break;
					case 4: 
						addTile(Lvls.part4[i]);
						break;
					case 5: 
						addTile(Lvls.part5[i]);
						break;
					case 6: 
						addTile(Lvls.part6[i]);
						break;
					case 7: 
						addTile(Lvls.part7[i]);
						break;
					case 8: 
						addTile(Lvls.part8[i]);
						break;
					case 9: 
						addTile(Lvls.part9[i]);
						break;
				}
			}
		
		}
		//// giving tiles the art end giving them a ID
		private function addTile(id:int):void
		{
			var tileID:int;
			switch (id)
			{
				case 1: 
					tile = new wall_MC();
					tileID = 1;
				break;
				case 2: 
					tile = new floortile_MC_CUBE();
					tileID = 2;
				break;
				case 3: 
					tile = new Fakefloor_MC_CUBE();
					tileID = 3;
					tile.stop();
				break;
				case 4: 
					tile = new SpikesOut_MC_CUBE();
					tileID = 4;
				break;
				case 5: 
					tile = new keyTile_MC_CUBE();
					tileID = 5;
				break;
				case 6: 
					tile = new mapTile_MC_CUBE();
					tileID = 6;
				break;
				case 7:
					tile = new KeyDoor_MC_CUBE();
					tileID = 7;
				break;
			}
			_alltiles.push(tile);
			addChild(tile);
			tile.x = (Xpos * 32) - 32;
			tile.y = Ypos * 32;
			if (tileID == 3) 
			{
				_allTilesID.push(_alltiles.length - 1);
			}
			
		}
		
	}

}
