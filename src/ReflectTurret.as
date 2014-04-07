package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	public class ReflectTurret extends Turret 
	{
		
		private var direction : int = -90;
		private var moveAmount : int = 5;
		public function ReflectTurret(x :int, y :int, state :FlxState,projManRef :ProjectileManager, textures : Array, enemyManager:EnemyManager, turretType : int = 1) 
		{
			super(x - 10, y, state, projManRef,textures,enemyManager, 0);
			soundManager = SoundManager.GetInstance();
			turretType = 3;
			name = "Scatter Turret LVL :" + turretMountTex;
			weapon.setBulletOffset(origin.x, 0);
			this.mountSprite.visible = false;
			
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
			
		
			
			
		}
		
		//} endregion
		
		//{ region Weapon
		
		
		
		//}endregion
		
	}

}