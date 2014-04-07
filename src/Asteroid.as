package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	
	public class Asteroid extends EnemyShip 
	{
	
		public function Asteroid(x :int, y :int, state :FlxState, projMan :ProjectileManager,fallSpeed : Number,scoreNumber : int,texture : Class) 
		{
			this.fallSpeed = fallSpeed + (HUD.waveNumber)/10;
			super(x, y, state, projMan, fallSpeed, scoreNumber,texture);
			this.health = 100 + HUD.waveNumber * 10;
			
		}
		
		public override function update() : void
		{
			if (y < 0)
			{
				if (fallSpeed < 0)
				{
					fallSpeed *= -1;
				}
			}
			if (fallSpeed > 5)
			{
				fallSpeed = 5;
			}
			healthBar.y = y - 10;
			healthBar.x = x;
			this.y += fallSpeed * FlxG.timeScale;
			
			this.angle += fallSpeed;
			if (health <= 0 )
			{
				kill();
				healthBar.kill();
				HUD.score += 100;
				x = -100;
				y = -100;
			}
			
		}
		
	}

}