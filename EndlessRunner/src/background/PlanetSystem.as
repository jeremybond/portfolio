package background 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Kit va de Bunt
	 * 
	 * this class makes use off BitmapData if is much more efficient than my first attempt with the displaylist
	 * 
	 * the quality of the this class is easy to changing by changing the variable thisScale 
	 * if you fill in 16 for you get a very low quality
	 * if you fill in 0.27 you get a hire quality
	 * the highest number of pixels flash player 10 can hold in a bitmapdata is 16.777.215
	 * if you fill in 0.27 you get 15.800.000 pixel that is almost the highest
	 */
	public class PlanetSystem extends Sprite
	{
		private var speed:int = 3;
		private var newSpawnTime:int = 0;
		private var xD:Number = 0;
		private var canvas:Bitmap;
		private var canvasData:BitmapData;
		private var Planetdata:BitmapData;
		private var PlanetMC_Holder:MovieClip;
		private var clipWidth:Number=392;
		private var clipHeight:Number = 392;
		private var thisScale:Number = 1; //higher is lower resolution
		private var thisWidth:int = (1280 / thisScale);
		private var thisHeight:int = (900 / thisScale);
		private var drawArea:Rectangle = new Rectangle(0, 0, thisWidth, thisHeight);
		public function PlanetSystem() 
		{
			// create MobieClip
			PlanetMC_Holder =new PlanetMC();
			
			//store movieClip in bitmapdata
			Planetdata = new BitmapData(clipWidth,clipHeight,true);
			Planetdata.draw(PlanetMC_Holder);
			
			//create canvas to draw planets on
			canvasData = new BitmapData(thisWidth, thisHeight, true, 0x00FFFFFF);
			
			//put canvas in bitmap and add it to the stage
			canvas = new Bitmap(canvasData);
			canvas.scaleX = thisScale;
			canvas.scaleY = thisScale;
			this.addChild(canvas);
		}
		
		//this loop moves one planet over the screen an creats an new one if it is gone.
		private var yposition:int = (Math.random() * (thisHeight - 200/thisScale)) + 100/thisScale;
		private var xposition:int;
		private var planetScale:Number = (1 / thisScale) * (Math.random() * 3 + 1);
		private var spawnDistance:int= planetScale * (200 + 30);
		public function loop():void {
			canvasData.lock();
			wipe(false);
			xD-=speed/thisScale;
			if (xposition < -spawnDistance) {
				xD = 0;
				planetScale = (1 / thisScale) * (Math.random() * 3 + 1);
				spawnDistance = (200 + 30)  * planetScale;
				yposition = (Math.random() * (thisHeight - 200/thisScale)) + 100/thisScale;
			}
			xposition = thisWidth + spawnDistance +xD;
			var mat:Matrix = new Matrix();
			
			mat.scale(planetScale,planetScale);
			mat.translate(xposition,yposition);
			canvasData.draw(PlanetMC_Holder,mat);
			canvasData.unlock(drawArea);
		}
		
		//with this function you can either wipe or blur canvasData
		private function wipe(Blur:Boolean = false):void {
			if(Blur){
				var blur:BlurFilter = new BlurFilter(16,16,1);
				canvasData.applyFilter(canvasData, drawArea, new Point(), blur);
			}else {
				canvasData.fillRect(drawArea, 0x00ffffff);
			}
		}
		
		//first attempt
		
		/*[Embed(source = "../files/Planet green4.png")]
		private var p1:Class;
		private var speed:int = 10;
		private var newSpawnTime:int = 0;
		private var bitmapPlanet:Bitmap;
		
		private var planetArray:Vector.<Bitmap> = new Vector.<Bitmap>;
		public function PlanetSystem() 
		{
			
			spawnPlanet();
		}
		private function spawnPlanet():void {
			planetArray.push(new p1());
			var ranScale:Number = (Math.random()*3 +1);
			planetArray[planetArray.length - 1].scaleX = ranScale*2;
			planetArray[planetArray.length - 1].scaleY = ranScale*2;
			var planetSize:int = planetArray[planetArray.length - 1].width;
			planetArray[planetArray.length - 1].x = - planetSize / 2;
			planetArray[planetArray.length - 1].y = - planetSize / 2;
			planetArray[planetArray.length - 1].x += 1280 + 1500;
			planetArray[planetArray.length - 1].y += Math.random()*(720*2);
			addChild(planetArray[planetArray.length - 1]);
			//trace("=-=============="+planetSize);
			newSpawnTime = planetSize/speed + Math.random() * (200/speed) + (600/speed);
		}
		
		public function loop():void {
			for (var i:int = 0; i < planetArray.length; i++) 
			{
				if (planetArray[i].x < -1500) {
					removeChild(planetArray[i]);
					planetArray.splice(i, 1);
				}else{
					planetArray[i].x -= speed;
				}
			}
			if (newSpawnTime < 0) {
				spawnPlanet();
			}else {
				newSpawnTime--;
			}
			//trace(newSpawnTime);
		}*/
	}

}