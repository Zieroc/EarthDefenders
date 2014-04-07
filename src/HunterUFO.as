package  
{
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.*;
	
	public class HunterUFO extends EnemyShip 
	{
		[Embed(source = "../src/Assets/alienGun.png")] protected var alienGunTextureClass:Class;
		
		private var cannon : FlxSprite;
		private var turretManager : TurretManager; 
		public function HunterUFO(x :int, y :int, state :FlxState, projMan :ProjectileManager,fallSpeed : Number,scoreNumber : int,texture : Class,turretManager : TurretManager) 
		{
			this.turretManager = turretManager;
			this.health = 100 + HUD.waveNumber * 10;
			this.fallSpeed = fallSpeed + (HUD.waveNumber)/10;
			super(x, y, state, projMan, fallSpeed, scoreNumber,texture);
			cannon = new FlxSprite(x + origin.x - 8, y + height, alienGunTextureClass);
			state.add(cannon);
			weapon = new FlxWeapon("Weapon", this, "x", "y");
			weapon.makeImageBullet(50, BulletTextureClass, width / 2, height + 1);
			var bulletFall:int = HUD.waveNumber * 20 + 20;
			if (bulletFall > 700)
			{
				bulletFall = 700;
			}
			weapon.setBulletDirection(FlxWeapon.BULLET_DOWN,  bulletFall);
			weapon.setBulletOffset(origin.x, height+3);
			weapon.setFireRate(2000);
			
		}
		
		public override function update() : void
		{
			if (y < 0)
			{
				if (fallSpeed < 0)
				{
					fallSpeed *= -1.5;
				}
			}
			if (fallSpeed > 5)
			{
				fallSpeed = 5;
			}
			healthBar.y = y - 10;
			healthBar.x = x;
			cannon.y = y + height;
			this.y += fallSpeed  * FlxG.timeScale;
			
			var closestEnemy : Turret = null;
			var dist : Number = 99999;
			
			for (var i : int = 0; i < turretManager.getTurrets().members.length; i++)
			{
				if ( turretManager.getTurrets().members[i] != null)
				{
					var temp : Turret =  turretManager.getTurrets().members[i] as Turret;
					if (FlxU.getDistance(new FlxPoint(temp.x, temp.y), new FlxPoint(cannon.x, cannon.y)) < dist &&FlxU.getDistance(new FlxPoint(temp.x, temp.y), new FlxPoint(cannon.x, cannon.y)) < 350 )
					{
						closestEnemy = temp;
						dist = FlxU.getDistance(new FlxPoint(temp.x, temp.y), new FlxPoint(cannon.x,cannon.y));
					}
				}
			}
			if (temp != null)
			{
				if (temp.x < 10 && temp.y < 10)
				{
					
				}
				else
				{
					cannon.angle = FlxU.getAngle(new FlxPoint(cannon.x, cannon.y), new FlxPoint(temp.x , temp.y)) - 90;
					weapon.setBulletDirection(cannon.angle, 150);
					if (onScreen())
					{
						fire();
					}
				}
			}
			if (health <= 0 )
			{
				kill();
				healthBar.kill();
				HUD.score += 100;
				x = -100;
				y = -100;
			}
			
		}
		
		protected override function fire():void
		{
			var fired :Boolean = weapon.fire();
			if (fired == true)
			{
				weapon.currentBullet.color = FlxG.RED;
				//trace("IS: " + weapon.currentBullet.y);
				//trace("SHOULD BE: " + y + height);
				projMan.addProjectile(weapon.currentBullet);
				soundManager.playSoundEffect("alien blaster");
			}
		}
		override public function kill():void 
		{
			var random:Number =  Math.random() * 100;
			
			if (random < 10)
			{
				var levelState : PlayState = state as PlayState;
				levelState.powerUpManager.AddPowerUp(new PowerUp(x, y, int(Math.random() * 5)));
			}
			cannon.kill();
			super.kill();
		}
	}

}