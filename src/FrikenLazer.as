package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	public class FrikenLazer extends Turret 
	{
		//private var soundManager : SoundManager;
		private var direction : int = -90;
		private var strenght : int = 5;
		public var firing : Boolean = false;
		//private var enemyManager : EnemyManager;
		public function FrikenLazer(x :int, y :int, state :FlxState,projManRef :ProjectileManager,textures : Array,enemyManager : EnemyManager,turretType : int = 1) 
		{
			super(x, y, state, projManRef, textures, enemyManager, 1);
			soundManager = SoundManager.GetInstance();
			this.enemyManager = enemyManager;
			switch(turretType)
			{
				case 0 : 
					strenght = 5;
					break;
				case 1 : 
					strenght = 10;
					break;
				case 2 : 
					strenght = 15;
					break;
				default : 
					
					break;
			}
		}
		
		
		
		override public function update():void 
		{
			
			firing = true;
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
			if (closestEnemy != null)
			{
				closestEnemy.health -= strenght / 100;
				
				this.angle = FlxU.getAngle(new FlxPoint(x, y), new FlxPoint(closestEnemy.x, closestEnemy.y)) - 90;
				firing = true;
				
				soundManager.laserHum();
				
			}
			else
			{
				firing = false;
			}
				
		
		
		
		if (health <= 0)
		{
			kill();
			healthBar.kill();
			x = -100;
			y = -100;
		}
		trace("Fire : " + firing);
		
		if (firing == true)
		{
			PlayState.background.drawLine(this.x + this.origin.x, this.y + this.origin.y, closestEnemy.x + closestEnemy.origin.x, closestEnemy.y +  closestEnemy.origin.y, 0xffff0000, strenght);
		}
		
	
		
	}
	}
}