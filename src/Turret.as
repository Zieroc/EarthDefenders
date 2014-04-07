package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * ...
	 * @author ...
	 */
	public class Turret extends FlxSprite
	{
		//{ region Variables
		[Embed(source = "../src/Assets/turretMounting.png")] protected var turretMountTex:Class;
		[Embed(source = "../src/Assets/Bullet.png")] protected var BulletTextureClass:Class;
		
		
		private var textures : Array;
		protected var weapon :FlxWeapon;
		protected var healthBar :FlxBar;
		protected var projManRef :ProjectileManager;
		protected var mountSprite : FlxSprite
		protected var turretType : int = 1;
		protected var enemyManager : EnemyManager;
		protected var soundManager : SoundManager;
		public var name : String = "Default Turret Name that should be overwritten and never actually shown";
		
		//}
		
		//{ region Constructor
		
		public function Turret(x :int, y :int, state :FlxState,projManRef :ProjectileManager,textures : Array,enemyManager : EnemyManager,turretType : int = 1) 
		{
			this.enemyManager = enemyManager;
			this.textures = textures;
			var headTexture : Class;
			var mountTexture : Class;
			soundManager = SoundManager.GetInstance();
			switch(turretType)
			{
				case 0 : 
					headTexture = textures[0];
					mountTexture = turretMountTex;
					weapon = new FlxWeapon("Weapon", this, "x", "y");
					weapon.makeImageBullet(50, BulletTextureClass, width / 2, height);
					weapon.setFireRate(1000);
					break;
				case 1 :
					headTexture = textures[1];
					mountTexture = turretMountTex;
					weapon = new FlxWeapon("Weapon", this, "x", "y");
					weapon.makeImageBullet(50, BulletTextureClass, width / 2, height);
					weapon.setFireRate(500);
				break;
				case 2 :
					headTexture = textures[2];
					mountTexture = turretMountTex;
					weapon = new FlxWeapon("Weapon", this, "x", "y");
					weapon.makeImageBullet(50, BulletTextureClass, width / 2, height);
					weapon.setFireRate(100);
					
				break
			}
			super(x, y, headTexture);
			state.add(this);
		
			this.projManRef = projManRef;
			
			this.origin.x = 17;
			weapon.setFiringPosition(origin.x, origin.y, 0, 0);
			mountSprite = new FlxSprite(x+4, y + 10, mountTexture);
			state.add(mountSprite);
			name = "Standard Turret LVL :" + turretMountTex;
			this.health = 100;
			healthBar = new FlxBar(x - 25, y + 35, FlxBar.FILL_LEFT_TO_RIGHT, 80, 5, this, "health", 0, 100, false);
			state.add(healthBar);
			this.immovable = true;
		}
		
		//} endregion
		
		override public function update():void 
		{
			super.update();
			if (health <= 0)
			{
				kill();
				healthBar.kill();
				x = -100;
				y = -100;
			}
			
			var closestEnemy : EnemyShip = null;
			var dist : Number = 99999;
			
			for (var i : int = 0; i < enemyManager.getEnemies().members.length; i++)
			{
				if (enemyManager.getEnemies().members[i] != null)
				{
					var temp : EnemyShip = enemyManager.getEnemies().members[i] as EnemyShip;
					if (temp.health > 0 && temp.onScreen())
					{
						if (FlxU.getDistance(new FlxPoint(temp.x, temp.y), new FlxPoint(x, y)) < dist &&FlxU.getDistance(new FlxPoint(temp.x, temp.y), new FlxPoint(x, y)) < 350 )
						{
							closestEnemy = temp;
							dist = FlxU.getDistance(new FlxPoint(temp.x, temp.y), new FlxPoint(x, y));
						}
					}
				}
			}
			if ( closestEnemy != null && closestEnemy.x > 10 && closestEnemy.y > 10)
			{
				this.angle = FlxU.getAngle(new FlxPoint(x, y), new FlxPoint(closestEnemy.x+ 10, closestEnemy.y + closestEnemy.origin.y)) - 90;
				weapon.setBulletDirection(FlxU.getAngle(new FlxPoint(x, y), new FlxPoint(closestEnemy.x+ 10, closestEnemy.y + closestEnemy.origin.y)) - 90,1000);
				
				
				fire();
			
			}
			
		}
		
		//} endregion
		
		//{ region Weapon
		
		protected function fire():void
		{
			var fired :Boolean = weapon.fire();
			if (fired == true)
			{
				projManRef.addTurretProj(weapon.currentBullet);
				switch(turretType)
				{
					case 0 : weapon.currentBullet.bulletDamage = 5; break;
					case 1 : weapon.currentBullet.bulletDamage = 5; break;
					case 2 : weapon.currentBullet.bulletDamage = 3; break;
				}
				soundManager.playSoundEffect("gun shot");
				weapon.setBulletOffset(origin.x, 0);
			}
		}
		override public function kill():void 
		{
			mountSprite.visible = false;
			healthBar.visible = false;
			healthBar.kill();
			mountSprite.kill();
			super.kill();
		}
		
		//}endregion
		
	}

}