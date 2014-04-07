package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	public class ScatterShotTurret extends Turret 
	{
		
		private var direction : int = -90;
		private var moveAmount : int = 5;
		public function ScatterShotTurret(x :int, y :int, state :FlxState,projManRef :ProjectileManager,textures : Array,turretType : int = 1) 
		{
			super(x, y, state, projManRef,textures,enemyManager, 1);
			soundManager = SoundManager.GetInstance();
			switch(turretType)
			{
				case 0 : 
					weapon.setFireRate(300);
					break;
				case 1 : 
					weapon.setFireRate(200);
					break;
				case 2 : 
					weapon.setFireRate(100);
					break;
				default : 
					weapon.setFireRate(100);
					break;
			}
			name = "Scatter Turret LVL :" + turretMountTex;
			weapon.setBulletOffset(origin.x, 0);
		}
		
		
		override public function update():void 
		{
			
			
			if (health <= 0)
			{
				kill();
				healthBar.kill();
				x = -100;
				y = -100;
			}
			fire();
			
			weapon.setBulletDirection(direction, 250);
			this.angle = direction;
			
			
		}
		
		//} endregion
		
		//{ region Weapon
		
		protected override function fire():void
		{
			var fired :Boolean = weapon.fire();
			if (fired == true)
			{
				projManRef.addTurretProj(weapon.currentBullet);
				weapon.currentBullet.bulletDamage = 3;
				direction +=moveAmount;
				if (direction > -75)
				{
					direction = -105;
				}
				if (direction < -104)
				{
					soundManager.playSoundEffect("shotGun");
				}
			}
		}
		
		//}endregion
		
	}

}