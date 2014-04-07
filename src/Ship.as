package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	public class Ship extends FlxSprite
	{
		[Embed(source = "../src/Assets/ship.png")] protected var shipTextureClass:Class;
		
		private const xSpeed : Number = 5;
		public function Ship(x : int , y : int , state : FlxState) 
		{
			super(x, y, shipTextureClass)
			state.add(this);
			this.immovable = true;
			this.height = 10;
		}
		
		override public function update():void 
		{
			super.update();
			if (FlxG.keys.A && x > 0)
			{
				this.x -= xSpeed * FlxG.timeScale;
				this._facing = LEFT;
				scale.x = -1;
			}
			else if ( FlxG.keys.D && x < 550)
			{
				this.x += xSpeed* FlxG.timeScale;
				scale.x = 1;
			}
		}
	}

}