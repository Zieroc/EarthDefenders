package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	public class Tutorial extends FlxState
	{
		[Embed(source = "../src/Assets/creditsPage1.png")] protected var page1Class:Class;
		[Embed(source = "../src/Assets/creditsPage2.png")] protected var page2Class:Class;
		[Embed(source = "../src/Assets/creditsPage3.png")] protected var page3Class:Class;
		[Embed(source = "../src/Assets/creditsPage4.png")] protected var page4Class:Class;
	
		private var page1 : FlxSprite;
		private var page2 : FlxSprite;
		private var page3 : FlxSprite;
		private var page4 : FlxSprite;
		private var nextButton : FlxButton;
		private var backButton : FlxButton;
		private var controller : int = 1;
		public function Tutorial() 
		{
			page1 = new FlxSprite( -640, 0, page1Class);
			page2 = new FlxSprite( -640, 0, page2Class);
			page3 = new FlxSprite( -640, 0, page3Class);
			page4 = new FlxSprite( -640, 0, page4Class);
			nextButton = new FlxButton(540, 440, "Next",nextButtonGO);
			backButton = new FlxButton(0, 440, "Back",backButtonGO);
			
			add(page1);
			add(page2);
			add(page3);
			add(page4);
			add(nextButton);
			add(backButton);
			
			FlxG.mouse.show();
		}
		override public function create():void 
		{
			super.create();
			Menu.tutorialRead = true;
			FlxG.flash(0xff000000, 1);
		}
		override public function update():void 
		{
			super.update();
			switch(controller)
			{
				case 0 : break;
			case 1 :
				if (page1.x < 0)
				{
					page1.x -= (page1.x - 0) / 10;
				}
				
				if (page2.x > -640)
				{
					page2.x -= page2.x - (-640);
				}
				
				break;
			case 2 :
				if (page2.x < 0)
				{
					page2.x -= (page1.x - 0) / 10;
					
				}
				if (page1.x > -640)
				{
					page1.x -= page1.x - (-640);
				}
				
				if (page3.x > -640)
				{
					page3.x -= page3.x - (-640);
				}
				
				break;
			case 3 : 
				if (page3.x < 0)
				{
					page3.x -= (page3.x - 0) / 10;
					
				}
				if (page2.x > -640)
				{
					page2.x -= page2.x - (-640);
				}
				
				if (page4.x > -640)
				{
					page4.x -= page4.x - (-640);
				}
				break;
			case 4 :
				if (page4.x < 0)
				{
					page4.x -= (page4.x - 0) / 10;
					
				}
				if (page3.x > -640)
				{
					page3.x -= page3.x - (-640);
				}
				break;
				
			}
			
		}
		public function nextButtonGO() : void
		{
			controller ++;
			if (controller == 5)
			{
				new MedalManager().unlock("The Defender's Guide to the Galaxy");
				FlxG.switchState(new Menu);
			}
		}
		public function backButtonGO() : void
		{
			
			controller --;
			if (controller == 0)
			{
				new MedalManager().unlock("The Defender's Guide to the Galaxy");
				FlxG.switchState(new Menu);
			}
		}
	}

}