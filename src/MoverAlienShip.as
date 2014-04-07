package
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.*;
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	public class MoverAlienShip extends EnemyShip 
	{
		private var points : Array;
		private var currentNode : int = 0;
		private var speed : int = 100;
		private var trail : TrailRenderer;
		//private var state : FlxState;
		public function MoverAlienShip(x :int, y :int, state :FlxState, projMan :ProjectileManager,fallSpeed : Number,scoreNumber : int,AlienShipTextureClass:Class,points : Array,speed : int = 50) 
		{
			this.state = state;
			trail = new TrailRenderer(state, this, AlienShipTextureClass);
			super(x, y, state, projMan, fallSpeed, scoreNumber, AlienShipTextureClass);
			this.speed = speed;
			this.points = points;
			trace("Point : " + points[1].x + " " + points[1].y);
			weapon.setBulletOffset(0, 40);
			weapon.setFireRate(5000);
		}
		override public function kill():void 
		{
			super.kill();
			state.remove(trail.trail);
		}
		override public function update():void 
		{
			//super.update();
			healthBar.y = y - 10;
			healthBar.x = x;
			
			
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
			trail.Update(0);
			weapon.setBulletOffset(0, 40);
			if (points.length > 1)
				{
					if (this.x > points[currentNode].x)
					{
						this.velocity.x = -speed;
					}
					if (this.x < points[currentNode].x)
					{
						this.velocity.x = speed;
					}
					
					if (this.y > points[currentNode].y)
					{
						this.velocity.y = -speed;
					}
					if (this.y < points[currentNode].y)
					{
						this.velocity.y = speed;
					}
					if (FlxU.getDistance(new FlxPoint(x,y), new FlxPoint(points[currentNode].x,points[currentNode].y)) < 10)
					{
						currentNode++;
						if (currentNode >= 3)
						{
							currentNode = 0;
						}
					}
			
			}
		}
		override protected function fire():void
		{
			var fired :Boolean = weapon.fire();
			this.weapon.setBulletDirection(90, 150);
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

	}
}