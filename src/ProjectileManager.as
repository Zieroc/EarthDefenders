package  
{
	import flash.net.GroupSpecifier;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.system.FlxQuadTree;
	import org.flixel.*;
	/**
	 * ...
	 * @author ...
	 */
	public class ProjectileManager 
	{
		//{ region Variables
		
		private var projectiles : FlxGroup;
		private var turretProj : FlxGroup;
		private var reversedProjectiles : FlxGroup;
		private var playerRef : Ship;
		private var earthRef : Earth;
		private var soundManager : SoundManager;
		//} endregion 
		
		
		//{ region Constructor
		public function ProjectileManager(state :FlxState, playerRef : Ship, earthRef : Earth) 
		{
			soundManager = SoundManager.GetInstance();
			this.playerRef = playerRef;
			this.earthRef = earthRef;
			projectiles = new FlxGroup(500);
			turretProj = new FlxGroup(500);
			reversedProjectiles = new FlxGroup(500);
			state.add(projectiles);
			state.add(turretProj);
			state.add(reversedProjectiles);
		}
		
		//} endregion
		
		// region Update
		
		public function update():void
		{
			for (var i :int = 0; i < projectiles.length; i++)
			{
				var temp : Bullet = projectiles.members[i] as Bullet;
				if (!temp.onScreen() || !temp.exists)
				{
					temp.kill();
					removeFromProjectile(temp);
					i--;
				}
			}
			
			for ( i = 0; i < turretProj.length; i++)
			{
				var temp : Bullet = turretProj.members[i] as Bullet;
				if (!temp.onScreen() || !temp.exists)
				{
					temp.kill();
					removeFromTurretProj(temp);
					i--;
				}
				else if (temp.velocity.x == 0 && temp.velocity.y == 0)
				{
					temp.kill();
					removeFromTurretProj(temp);
					i--;
				}
			}
			
			for ( i = 0; i < reversedProjectiles.length; i++)
			{
				var temp : Bullet = reversedProjectiles.members[i] as Bullet;
				if (!temp.onScreen() || !temp.exists)
				{
					temp.kill();
					removeFromReversedProjectiles(temp);
					i--;
				}
			}
		}
		
		//} endregion
		
		//{ region Add/Remove Projectiles
		public function collisionDetection() : void
		{
			FlxG.collide(projectiles, playerRef, reverse);
			FlxG.collide(projectiles, earthRef,damageEarth);
		}
		
		private function damageEarth(FlxObject1 : FlxObject, FlxObject2 : FlxObject) : void
		{
			var objectOfInterest : FlxObject; 
			if (FlxObject1 == playerRef)
			{
				objectOfInterest = FlxObject2;
			}
			else
			{
				objectOfInterest = FlxObject1;
			}
			var temp : Bullet = objectOfInterest as Bullet; 
			
			earthRef.health -= temp.bulletDamage;
			temp.kill();
			removeFromProjectile(temp);
			
		}
		
		private function reverse(FlxObject1 : FlxObject, FlxObject2 : FlxObject) : void
		{
			var objectOfInterest : FlxObject; 
			if (FlxObject1 == playerRef)
			{
				objectOfInterest = FlxObject2;
			}
			else
			{
				objectOfInterest = FlxObject1;
			}
			var temp : Bullet = objectOfInterest as Bullet; 
			temp.velocity.y = -100;
			addReversedProjectile(temp);
			removeFromProjectile(temp);
			soundManager.playSoundEffect("bounce");
			trace("reverse");
		}
		
		public function addProjectile(bullet:Bullet):void
		{
			//bullet.alive = true;
			projectiles.add(bullet);
		}
		
		public function removeProjectile(index :int):void
		{
			
			if (index < projectiles.length)
			{
				projectiles.remove(projectiles.members[index], true);
			}
		}
		
		public function removeFromProjectile(bullet :Bullet):void
		{
			
			projectiles.remove(bullet, true);
		}
		
		public function addReversedProjectile(bullet:Bullet):void
		{
			//bullet.alive = true;
			reversedProjectiles.add(bullet);
		}
		
		public function removeReversedProjectile(index :int):void
		{
			
			if (index < projectiles.length)
			{
				reversedProjectiles.remove(projectiles.members[index], true);
			}
		}
		
		public function removeFromReversedProjectiles(bullet :Bullet):void
		{
			reversedProjectiles.remove(bullet, true);
		}
		
		public function addTurretProj(bullet:Bullet):void
		{
			//bullet.alive = true;
			turretProj.add(bullet);
		}
		
		public function removeTurretProj(index :int):void
		{
			
			if (index < turretProj.length)
			{
				turretProj.remove(turretProj.members[index], true);
			}
		}
		
		public function removeFromTurretProj(bullet :Bullet):void
		{
			turretProj.remove(bullet, true);
		}
		
		//}
		
		//{ region Getters/Setters
		
		public function getProjectiles():FlxGroup
		{
			return projectiles;
		}
		
		public function getReversedProjectiles():FlxGroup
		{
			return reversedProjectiles;
		}
		
		public function getTurretProj():FlxGroup
		{
			return turretProj;
		}
		
		//}
		
		public function clearProjectiles():void
		{
			projectiles.kill();
			projectiles.clear();
			projectiles.revive();
		}
		
		public function clearReversedProjectiles():void
		{
			reversedProjectiles.kill();
			reversedProjectiles.clear();
			reversedProjectiles.revive();
		}
		public function clearTurretProjectiles():void
		{
			turretProj.kill();
			turretProj.clear();
			turretProj.revive();
		}
		
	}

}