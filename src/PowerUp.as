package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	public class PowerUp extends FlxSprite
	{
		[Embed(source = "../src/Assets/EarthHealPowerup.png")] protected var EarthHealTextureClass:Class;
		[Embed(source = "../src/Assets/clearScreenPowerUp.png")] protected var clearScreenTextureClass:Class;
		
		
		public var type : int = 0 ;
		public function PowerUp(x : int, y : int,type : int = 0) 
		{
			var texture : Class;
			switch(type)
			{
				case 0 : texture = EarthHealTextureClass; break;
				case 1 : texture = EarthHealTextureClass; break;
				case 2 : texture = clearScreenTextureClass; break;
				case 3 : texture = clearScreenTextureClass; break;
				case 4 : texture = clearScreenTextureClass; break;
			}
			super(x, y, texture);
			this.type = type;
			this.velocity = new FlxPoint(0, 100);
		}
		
	}

}