package displayText 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Kit van de bunt
	 */
	public class PopText extends Sprite
	{
		public var ready:Boolean = false;
		private var textField:TextField;
		private var textForm:TextFormat;
		
		[Embed(source="../files/quarkstorm.ttf", fontFamily = "foo",
		mimeType = "application/x-font",
		fontWeight="normal",
		fontStyle="normal",
		advancedAntiAliasing="true",
		embedAsCFF = "false")]
		public var bar:String;
		
		//this function creates the text
		public function PopText(Text:String="+23",color:int = 0X00ffff,startSize:int =10) 
		{
			this.x += 300;
			this.y += 300;
			textForm = new TextFormat();
			textForm.font = "foo";
			textForm.size = startSize;
			textForm.align = "left";
			textForm.color = color;
			
			textField = new TextField();
			textField.defaultTextFormat = textForm;
			textField.embedFonts = true;
			textField.text = Text;
			textField.width = 3*startSize;
			textField.x = -(textField.width / 2);
			textField.y = -(textField.height / 2);
			addChild(textField);
		}
		
		private var change:Number = 1.02;
		
		//this function updates the text and sets ready to true if the text has fully animated
		public function loop():void {
			if(!ready){
				if (textField.scaleX <= 0) {
					ready = true;
				}else {
					change-= 0.1;
				}
				textField.scaleX += change;
				textField.scaleY += change;
			}
		}
	}
}