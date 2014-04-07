package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	public class Earth extends FlxSprite
	{
		[Embed(source = "../src/Assets/Earth.png")] protected var EarthTextureClass:Class;
		[Embed(source = "../src/Assets/TurretBase.png")] protected var TurretTextureClass:Class;

		private var healthBar : FlxBar;
		private var earthHealth : Number = 300;
		private var bar : FlxSprite;
		public function Earth(x :int , y : int, state : FlxState) 
		{
			super(x, y, EarthTextureClass);
			this.immovable = true;
			state.add(this);
			healthBar = new FlxBar(x + 100, y + 100, FlxBar.FILL_LEFT_TO_RIGHT, width - 200, 10, this, "health", 0, 300, false);
			health = earthHealth;
			bar = new FlxSprite(60, 340, TurretTextureClass);
			state.add(bar);
			state.add(healthBar);
		}
		
		
		override public function update():void 
		{
			super.update();
			if (health <= 0)
			{
				MedalManager.earthDestroyed = true;
				health = 0;
			}
			else if (health > 300)
			{
				health = 300;
			}
		}
	}

}