package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	public class Credits extends FlxState
	{
		private var starField : StarField;
		
		[Embed(source = "../src/Assets/CodeMonkeyImage.png")] protected var CodeMonkeyTextureClass:Class;
		[Embed(source = "../src/Assets/CodersImage.png")] protected var CodersImageTextureClass:Class;
		
		[Embed(source = "../src/Assets/ArtyPersonImage.png")] protected var ArtyTitleTextureClass:Class;
		[Embed(source = "../src/Assets/ArtistImage.png")] protected var ArtistTextureClass:Class;
		
		
		private var CodeMonkeySprite : FlxSprite;
		private var CodersSprite : FlxSprite;
		private var ArtTitleSprite : FlxSprite;
		private var ArtistSprite : FlxSprite;
		
		private var startButton : FlxButton;
	
		public function Credits() 
		{
			//100 180
			FlxG.mouse.show();
			FlxG.flash(0xff000000, 1);
			starField = new StarField();
			CodeMonkeySprite = new FlxSprite( -500, 20, CodeMonkeyTextureClass);
			CodersSprite = new FlxSprite(580, 80, CodersImageTextureClass);
			
			ArtTitleSprite = new FlxSprite( -500, 220, ArtyTitleTextureClass);
			ArtistSprite = new FlxSprite(580, 280, ArtistTextureClass);
			
			add(CodeMonkeySprite);
			add(CodersSprite);
			add(ArtTitleSprite);
			add(ArtistSprite);
			startButton = new FlxButton(300, 400, "Back", FadeOut);
			add(startButton);
			add(starField);
			
		}
		public function FadeOut() : void
		{
			FlxG.fade(0xff000000,1,StartGame);
		}
		public function StartGame() : void
		{
			FlxG.switchState(new Menu);
		}
		
		override public function update():void 
		{
			if (CodeMonkeySprite.x < 20)
			{
				CodeMonkeySprite.x -= (CodeMonkeySprite.x -20) / 10;
				ArtTitleSprite.x -= (ArtTitleSprite.x -20)/10;
			}
			
			if (CodersSprite.x > 80 )
			{
				CodersSprite.x -= (CodersSprite.x - 80) / 10;
				ArtistSprite.x -= (ArtistSprite.x - 80)/10;
			}
			super.update();
		}
		
	}

}