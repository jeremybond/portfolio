package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class Leef extends MovieClip
	{
		private var art:Array;
		
		
		public var life:int;
		public function Leef() 
		{
			art = [];
			
			
			
		}
		public function updateLife(newLife:int):void
		{
			life = newLife;
			for each (var hartje:MovieClip in art) 
			{
				removeChild(hartje);
			}
			art.splice(0, art.length);
			
			for (var i:int = 0; i < life; i++) 
			{
				var h:MovieClip = new hart();
				addChild(h);
				art.push(h);
				h.x = 50 * i;
			}
			
			
			
			
			trace(art);
			
		}
		
	}

}