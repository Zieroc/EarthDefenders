package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	
	/**
	 * ...
	 * @author Christy Carroll
	 */
	public class TankEnemyShip extends EnemyShip 
	{
		[Embed(source = "../src/Assets/NukeBullet.png")] protected var NukeBulletTextureClass:Class;
		
		public function TankEnemyShip(x :int, y :int, state :FlxState, projMan :ProjectileManager,fallSpeed : Number,scoreNumber : int, texture : Class) 
		{
			super(x, y, state, projMan, fallSpeed, scoreNumber,texture);
			
			weapon = new FlxWeapon("Weapon", this, "x", "y");
			weapon.makeImageBullet(50, NukeBulletTextureClass, width / 2 - 10, height + 1);
			var bulletFall:int = HUD.waveNumber * 20 + 10;
			if (bulletFall > 700)
			{
				bulletFall = 700;
			}
			weapon.setBulletDirection(FlxWeapon.BULLET_DOWN, bulletFall);
			weapon.setFireRate(5000);
			
			state.remove(healthBar);
			this.health = 150 + HUD.waveNumber * 10
			healthBar = new FlxBar(x, y - 10, FlxBar.FILL_LEFT_TO_RIGHT, width, 5, this, "health", 0, this.health, false);
			//health = 150;
			state.add(healthBar);
		}
		
		override protected function fire():void
		{
			var fired :Boolean = weapon.fire();
			if (fired == true)
			{
				//weapon.currentBullet.color = FlxG.RED;
				//trace("IS: " + weapon.currentBullet.y);
				//trace("SHOULD BE: " + y + height);
				weapon.currentBullet.bulletDamage = 25;
				projMan.addProjectile(weapon.currentBullet);
			}
		}
		
	}

}