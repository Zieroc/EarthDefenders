package  
{
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.net.GroupSpecifier;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.system.FlxQuadTree;
	import org.flixel.*;
	/**
	 * ...
	 * @author Christy Carroll
	 */
	public class TurretManager 
	{
		private var turrets :FlxGroup;
		private var projManagerRef :ProjectileManager;
		private var enemyManager : EnemyManager;
		private var soundManager : SoundManager;
		public function TurretManager(state :FlxState, projMan :ProjectileManager) 
		{
			soundManager = SoundManager.GetInstance();
			turrets = new FlxGroup(10);
			state.add(turrets);
			projManagerRef = projMan;
		}
		public function setEnemyManager(enemyManager : EnemyManager) : void
		{
			this.enemyManager = enemyManager;
		}
		public function collisionDetection() : void
		{
			FlxG.collide(turrets, projManagerRef.getProjectiles(), decHealth);
			FlxG.overlap(turrets, enemyManager.getEnemies(), shipCollide);
		}
		
		public function shipCollide(FlxObject1 : FlxObject, FlxObject2 : FlxObject) : void
		{
			var objectOfInterest : FlxObject;
			var otherObject : FlxObject;
			if (FlxObject1 is EnemyShip)
			{
				objectOfInterest = FlxObject1;
				otherObject = FlxObject2;
			}
			else
			{
				objectOfInterest = FlxObject2;
				otherObject = FlxObject1;
			}
			var temp : EnemyShip = objectOfInterest as EnemyShip; 
			var tempB : Turret = otherObject as Turret;
			
			if (tempB is ReflectTurret)
			{
				if (temp.fallSpeed > 0)
				{
					temp.fallSpeed *= -1;
				}
				if (temp.fallSpeed < -2)
				{
					temp.fallSpeed = -3;
				}
				tempB.health -= 10;
				temp.kill();
			}
			else
			{
				tempB.health -= 10;
				temp.kill();
			}
		}
		
		public function decHealth(FlxObject1 : FlxObject, FlxObject2 : FlxObject) : void
		{
			var objectOfInterest : FlxObject;
			var otherObject : FlxObject;
			if (FlxObject1 is Turret)
			{
				objectOfInterest = FlxObject1;
				otherObject = FlxObject2;
			}
			else
			{
				objectOfInterest = FlxObject2;
				otherObject = FlxObject1;
			}
			var temp : Turret = objectOfInterest as Turret; 
			var tempB : Bullet = otherObject as Bullet;
			if (temp is ReflectTurret)
			{
				temp.health -= tempB.bulletDamage /2;
				tempB.velocity.y = -150;
				projManagerRef.addReversedProjectile(tempB);
				soundManager.playSoundEffect("bounce");
			}
			else
			{
				temp.health -= tempB.bulletDamage * 2;
				tempB.kill();
			}
			
			trace("hurt");
		}
		
		public function addTurret(turret:Turret):void
		{
			turrets.add(turret);
		}
		
		public function removeTurret(turret:Turret):void
		{
			turrets.remove(turret);
		}
		
		public function getTurrets():FlxGroup
		{
			return turrets;
		}
		
	}

}