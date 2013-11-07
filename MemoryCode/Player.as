package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class Player extends MovieClip
	{
		private var art:MovieClip
		public function Player() 
		{
			art = new SnowmanArt();
			addChild(art);
			
			
			
		}
		public function up():void
		{
			y -= 7;
		}
		public function down():void
		{
			y += 7;
		}
		//public function stay():void
		//{
			//y -= 7;
		//}
		//public function stay2():void
		//{
			//y += 7;
		//
		//}	
		public function update():void
		{
			//trace("update");
			
			for each(var bal:MovieClip in Main.ballen)
			{
				if (bal.hitTestObject(this))
				{
					Main.main.removeChild(bal)
					Main.ballen.splice(Main.ballen.indexOf(bal), 1)
					
					if(Main.lifebar.life < 5){
						Main.lifebar.updateLife(Main.lifebar.life+1);//hier komen de levens erbij.
					}
				}
			}	
			for each (var vurbal:MovieClip in Main.vuurBallen) 
			{
				if (vurbal.hitTestObject(this)) 
				{
					Main.main.removeChild(vurbal)
					Main.vuurBallen.splice(Main.vuurBallen.indexOf(vurbal), 1)
					
					Main.lifebar.updateLife(Main.lifebar.life-1);
					
				}
			}
			for each (var vurkamp:MovieClip in Main.vuurKampen) 
			{
				if (vurkamp.hitTestObject(this))
				{
					Main.main.removeChild(vurkamp)
					Main.vuurKampen.splice(Main.vuurKampen.indexOf(vurkamp), 1)
					
					Main.lifebar.updateLife(Main.lifebar.life-1);
				}
			}
			
			/*
			for each(var bal:MovieClip in Main.ballen)
			{
				if (bal.hitTestObject(this))
				{
					
				}
			}*/
			
		}
	}
}