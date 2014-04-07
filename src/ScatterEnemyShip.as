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
	public class ScatterEnemyShip extends EnemyShip 
	{
		
		public function ScatterEnemyShip(x :int, y :int, state :FlxState, projMan :ProjectileManager,fallSpeed : Number,scoreNumber : int,texture : Class) 
		{
			super(x, y, state, projMan, fallSpeed, scoreNumber,texture);
			this.health = 100 + HUD.waveNumber * 10;
			this.fallSpeed = fallSpeed + (HUD.waveNumber)/10;
			//loadGraphic(ScatterAlienShipTextureClass);
			soundManager = SoundManager.GetInstance();
			weapon = new FlxWeapon("Weapon", this, "x", "y");
			weapon.makeImageBullet(50, BulletTextureClass, width / 2, height + 1);
			weapon.setBulletDirection(FlxWeapon.BULLET_DOWN, 50 + HUD.waveNumber);
			weapon.setFireRate(3000);
			
			state.remove(healthBar);
			healthBar = new FlxBar(x, y - 10, FlxBar.FILL_LEFT_TO_RIGHT, width, 5, this, "health", 0, this.health, false);
			//health = 125;
			state.add(healthBar);
		}
		
		override protected function fire():void
		{
			weapon.setBulletOffset(width / 2, height + 1)
			weapon.setBulletDirection(FlxWeapon.BULLET_DOWN,  fallSpeed *400);
			var fired :Boolean = weapon.fire();
			if (fired == true)
			{
				weapon.setFireRate(0);
				weapon.currentBullet.color = FlxG.GREEN;
				//trace("IS: " + weapon.currentBullet.y);
				//trace("SHOULD BE: " + y + height);
				projMan.addProjectile(weapon.currentBullet);
			}
			weapon.setBulletOffset(width / 3, height + 1)
			weapon.setBulletDirection(95,  fallSpeed *400);
			fired  = weapon.fire();
			if (fired == true)
			{
				weapon.currentBullet.color = FlxG.GREEN;
				//trace("IS: " + weapon.currentBullet.y);
				//trace("SHOULD BE: " + y + height);
				projMan.addProjectile(weapon.currentBullet);
				weapon.setFireRate(6000);
			}
			weapon.setBulletOffset(width - width / 3, height + 1)
			weapon.setBulletDirection(75,  fallSpeed *400);
			fired = weapon.fire();
			if (fired == true)
			{
				weapon.currentBullet.color = FlxG.GREEN;
				//trace("IS: " + weapon.currentBullet.y);
				//trace("SHOULD BE: " + y + height);
				projMan.addProjectile(weapon.currentBullet);
				soundManager.playSoundEffect("alien blaster");
			}
		}
		
	}

}