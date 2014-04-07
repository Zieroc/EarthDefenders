package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	public class Menu extends FlxState
	{
		private var starField : StarField;
		
		[Embed(source = "../src/Assets/DefenderWord.png")] protected var DefenderWordTextureClass:Class;
		[Embed(source = "../src/Assets/EarthWord.png")] protected var EarthWordTextureClass:Class;
		[Embed(source = "../src/Assets/EarthBig.png")] protected var EarthSpinTextureClass:Class;
		
		private var earthWordSprite : FlxSprite;
		private var DefenderWordSprite : FlxSprite;
		private var EarthSpinSprite : FlxSprite;
		private var startButton : FlxButton;
		private var creditsButton : FlxButton;
		private var tutorialButton : FlxButton;
		private  var READTHIS : FlxText;
		public static var tutorialRead : Boolean = false;
		public function Menu() 
		{
			//100 180
			
			FlxG.mouse.show();
			starField = new StarField();
			earthWordSprite = new FlxSprite( -500, 120, EarthWordTextureClass);
			DefenderWordSprite = new FlxSprite(580, 180, DefenderWordTextureClass);
			EarthSpinSprite = new FlxSprite(-300,  300, EarthSpinTextureClass);
			add(EarthSpinSprite);
			
			add(earthWordSprite);
			add(DefenderWordSprite);
			
			startButton = new FlxButton(300, 300, "Start", FadeOut);
			add(startButton);
			creditsButton = new FlxButton(300, 400, "Credits", FadeOutCred);
			add(creditsButton);
			tutorialButton = new FlxButton(300, 350, "Tutorial", FadeOutTut);
			add(tutorialButton);
			READTHIS = new FlxText(400, 350, 300, "<-- Read this Please", true);
			READTHIS.color = 0xff0000;
			
			add(READTHIS);
			add(starField);
		}
		override public function create():void 
		{
			super.create();
			SoundManager.GetInstance().playMenu();
		}
		public function FadeOut() : void
		{
			FlxG.fade(0xff000000,1,StartGame);
		}
		public function FadeOutCred() : void
		{
			FlxG.fade(0xff000000,1,CreditsScreen);
		}
		public function FadeOutTut() : void
		{
			FlxG.fade(0xff000000,1,TutorialScreen);
		}
		public function StartGame() : void
		{
			FlxG.switchState(new PlayState);
		}
		public function TutorialScreen() : void
		{
			FlxG.switchState(new Tutorial);
		}
		public function CreditsScreen() : void
		{
			FlxG.switchState(new Credits);
		}
		override public function update():void 
		{
			EarthSpinSprite.angle += 0.02;
			if (EarthSpinSprite.angle > 360)
			{
				EarthSpinSprite.angle = 0;
			}
			if (tutorialRead)
			{
				READTHIS.text = "Thanks you :D";
			}
			if (earthWordSprite.x < 20)
			{
				earthWordSprite.x -= (earthWordSprite.x -20)/10;
			}
			
			if (DefenderWordSprite.x > 80 )
			{
				DefenderWordSprite.x -= (DefenderWordSprite.x - 80)/10;
			}
			super.update();
		}
		
	}

}