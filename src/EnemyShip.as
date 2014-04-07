package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.*;
	/**
	 * ...
	 * @author ...
	 */
	public class EnemyShip extends FlxSprite
	{
		//{ region Variables
		[Embed(source = "../src/Assets/Bullet.png")] protected var BulletTextureClass:Class;
		
		protected var weapon :FlxWeapon;
		protected var healthBar :FlxBar;
		protected var projMan :ProjectileManager;
		public var fallSpeed : Number; 
		protected var scoreWorth : int;
		protected var state :FlxState;
		protected var soundManager : SoundManager;
		//} endregion
		
		//{ region Constructor
		public function EnemyShip(x :int, y :int, state :FlxState, projMan :ProjectileManager,fallSpeed : Number,scoreNumber : int,AlienShipTextureClass:Class)
		{
			trace("Created Enemy at : " + x + " , " + y);
			soundManager = SoundManager.GetInstance();
			this.state = state;
			super(x, y, AlienShipTextureClass);
			//allowCollisions = FlxObject.FLOOR;
			this.scoreWorth = scoreWorth;
			this.immovable = true;
			this.health = 100 + HUD.waveNumber * 10;
			this.fallSpeed = fallSpeed + (HUD.waveNumber) / 10;
			weapon = new FlxWeapon("Weapon", this, "x", "y");
			weapon.makeImageBullet(50, BulletTextureClass, width / 2, height + 1);
			var bulletFall:int = HUD.waveNumber * 20 + 20;
			if (bulletFall > 700)
			{
				bulletFall = 700;
			}
			weapon.setBulletDirection(FlxWeapon.BULLET_DOWN, bulletFall);
			weapon.setBulletOffset(origin.x,30);
			weapon.setFireRate(1000);
			
			healthBar = new FlxBar(x, y - 10, FlxBar.FILL_LEFT_TO_RIGHT, width, 5, this, "health", 0, this.health, false);
			//health = 100;
			
			this.projMan = projMan;
			
			state.add(this);
			state.add(healthBar);
		}
		
		//} endregion
		
		//{ region Update
		
		override public function update():void 
		{
			super.update();
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
			trace("Speed : ------------------------" + fallSpeed);
			healthBar.y = y - 10;
			healthBar.x = x;
			this.y += fallSpeed * FlxG.timeScale;
			
			if (health <= 0 )
			{
				kill();
				healthBar.kill();
				HUD.score += 100;
				x = -100;
				y = -100;
			}
			if (onScreen())
			{
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
				weapon.currentBullet.color = FlxG.RED;
				//trace("IS: " + weapon.currentBullet.y);
				//trace("SHOULD BE: " + (y + 40));
				trace("" + weapon.bulletsFired);
				projMan.addProjectile(weapon.currentBullet);
				soundManager.playSoundEffect("alien blaster");
			}
		}
		
		override public function kill():void 
		{
			var random:Number = Math.random() * 100;
			this.x = -1000;
			this.y = -1000;
			if (random < 10)
			{
				var levelState : PlayState = state as PlayState;
				levelState.powerUpManager.AddPowerUp(new PowerUp(x, y, int(Math.random() * 5)));
			}
			healthBar.kill();
			super.kill();
		}
		//}endregion
		
	}

}