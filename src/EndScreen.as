package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	public class EndScreen extends FlxState
	{
		private var starField : StarField;
		
		[Embed(source = "../src/Assets/EndScreen.png")] protected var EndScreenTextureClass:Class;
		
		
		private var endScreen : FlxSprite;
		private var backButton : FlxButton;
		private  var text : FlxText;
	
		public function EndScreen(wave : int , score : Number ) 
		{
			//100 180
			
			FlxG.mouse.show();
			endScreen = new FlxSprite(0, -480, EndScreenTextureClass);
			
			
			add(endScreen);
			
			MedalManager.postScore();
			
			backButton = new FlxButton(300, 350, "Menu",reset);
			add(backButton);
			text = new FlxText(400, 350, 300, "You got to Wave : " + wave + "\n With a score of : " + score, true);
			text.color = 0xffffffff;
			text.size = 16;
			
			add(text);
			
		}
		public function reset() : void
		{
			HUD.score = 0;
			HUD.waveNumber = 0;
			FlxG.switchState(new Menu);
		}
		override public function update():void 
		{
			super.update();
			if (endScreen.y < 0)
			{
				endScreen.y -= endScreen.y / 10
			}
		}
		override public function create():void 
		{
			super.create();
			SoundManager.GetInstance().playMenu();
		}
		
		
	}

}