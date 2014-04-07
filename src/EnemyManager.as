package  
{
	import flash.geom.Point;
	import flash.net.GroupSpecifier;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.system.FlxQuadTree;
	import org.flixel.*;
	/**
	 * ...
	 * @author Christy Carroll
	 */
	public class EnemyManager 
	{
		[Embed(source="../src/Assets/Levels/level1.txt", mimeType="application/octet-stream")]	private var level1Data:Class;
		[Embed(source="../src/Assets/Levels/level2.txt", mimeType="application/octet-stream")]	private var level2Data:Class;
		[Embed(source="../src/Assets/Levels/level3.txt", mimeType="application/octet-stream")]	private var level3Data:Class;
		[Embed(source="../src/Assets/Levels/level4.txt", mimeType="application/octet-stream")]	private var level4Data:Class;
		[Embed(source="../src/Assets/Levels/level5.txt", mimeType="application/octet-stream")]	private var level5Data:Class;
		[Embed(source="../src/Assets/Levels/level6.txt", mimeType="application/octet-stream")]	private var level6Data:Class;
		[Embed(source="../src/Assets/Levels/level7.txt", mimeType="application/octet-stream")]	private var level7Data:Class;
		[Embed(source="../src/Assets/Levels/level8.txt", mimeType="application/octet-stream")]	private var level8Data:Class;
		[Embed(source="../src/Assets/Levels/level9.txt", mimeType="application/octet-stream")]	private var level9Data:Class;
		[Embed(source="../src/Assets/Levels/level10.txt", mimeType="application/octet-stream")]	private var level10Data:Class;
		[Embed(source="../src/Assets/Levels/level11.txt", mimeType="application/octet-stream")]	private var level11Data:Class;
		[Embed(source="../src/Assets/Levels/level12.txt", mimeType="application/octet-stream")]	private var level12Data:Class;
		[Embed(source="../src/Assets/Levels/level13.txt", mimeType="application/octet-stream")]	private var level13Data:Class;
		[Embed(source="../src/Assets/Levels/level14.txt", mimeType="application/octet-stream")]	private var level14Data:Class;
		[Embed(source="../src/Assets/Levels/level15.txt", mimeType="application/octet-stream")]	private var level15Data:Class;
		[Embed(source="../src/Assets/Levels/level16.txt", mimeType="application/octet-stream")]	private var level16Data:Class;
		[Embed(source="../src/Assets/Levels/level17.txt", mimeType="application/octet-stream")]	private var level17Data:Class;
		[Embed(source="../src/Assets/Levels/level18.txt", mimeType="application/octet-stream")]	private var level18Data:Class;
		[Embed(source="../src/Assets/Levels/level19.txt", mimeType="application/octet-stream")]	private var level19Data:Class;
		[Embed(source="../src/Assets/Levels/level20.txt", mimeType="application/octet-stream")]	private var level20Data:Class;
		
		
		[Embed(source = "../src/Assets/alienship.png")] protected var AlienNormalTexture : Class;
		[Embed(source = "../src/Assets/asteroid1.png")] protected var asteroidTexture : Class;
		[Embed(source = "../src/Assets/alienshipBigger.png")] protected var ScatterAlienShipTextureClass:Class;
		[Embed(source = "../src/Assets/alienshipTank.png")] protected var TankAlienShipTextureClass:Class;
		[Embed(source = "../src/Assets/alienshipmover.png")] protected var MoverAlienShipTextureClass:Class;
		[Embed(source = "../src/Assets/alienshipShooter.png")] protected var HunterAlienShipTextureClass:Class;
		[Embed(source = "../src/Assets/WaveComplete.png")] protected var waveCompleteTextureClass:Class;
		
		//{ region Variables
		
		private var enemies : FlxGroup;
		private var  projManRef : ProjectileManager;
		private var stateRef : FlxState;
		private var currentWave : int;
		private var playerRef : Ship;
		private var turretManager : TurretManager;
	    private var waveComplete : FlxSprite;
		private var earth : Earth;
		private var soundManager : SoundManager;
		//} endregion 
		
		
		//{ region Constructor
		public function EnemyManager(state :FlxState, projManRef : ProjectileManager,playerRef : Ship,turretManager : TurretManager,earth : Earth) 
		{
			this.soundManager = SoundManager.GetInstance();
			this.earth = earth;
			this.waveComplete = new FlxSprite(-1000, 200, waveCompleteTextureClass);
			state.add(waveComplete);
			this.playerRef = playerRef;
			this.turretManager = turretManager;
			this.stateRef = state;
			this.projManRef = projManRef;
			enemies = new FlxGroup(100);
			state.add(enemies);
			currentWave = 1;
		}
		
		//} endregion
		
		// region Update
		
		public function loadWave(waveNumber : int) : void
		{
			//waveNumber = 4;
			clearEnemies();
			projManRef.clearProjectiles();
			projManRef.clearReversedProjectiles();
			projManRef.clearTurretProjectiles();
			if (waveNumber != 1)
			{
				waveComplete.x = 1000;
			}
			//
			if (enemies.countLiving() < 1)
			{
				var waveText : String ;
				switch(waveNumber)
				{
					case 1 :waveText = new level1Data(); break;
					case 2 :waveText = new level2Data(); break;
					case 3 :waveText = new level3Data(); break;
					case 4 :waveText = new level4Data(); break;
					case 5 :waveText = new level5Data(); break;
					case 6 :waveText = new level6Data(); break;
					case 7 :waveText = new level7Data(); break;
					case 8 :waveText = new level8Data(); break;
					case 9 :waveText = new level9Data(); break;
					case 10 :waveText = new level10Data(); break;
					case 11 :waveText = new level11Data(); break;
					case 12 :waveText = new level12Data(); break;
					case 13 :waveText = new level13Data(); break;
					case 14 :waveText = new level14Data(); break;
					case 15 :waveText = new level15Data(); break;
					case 16 :waveText = new level16Data(); break;
					case 17 :waveText = new level17Data(); break;
					case 18 :waveText = new level18Data(); break;
					case 19 :waveText = new level19Data(); break;
					case 20 :waveText = new level20Data(); break;
					
					//repeat for all waves.
					
					
					default : waveText = new level20Data(); break;
				}
				
				var unitTextArray : Array = waveText.split("\n");
				trace("Loading wave " + waveNumber + " : with : " + unitTextArray.length + " Units");
				for (var i : int = 0; i < unitTextArray.length; i++)
				{
					
					var unitSpecs : Array = unitTextArray[i].split(" ");
					if (unitSpecs[1] > 1 || unitSpecs[1] < -1)
					{
						switch(int(unitSpecs[0]))
						{
							case 1 : 
								addEnemy(new EnemyShip(int(unitSpecs[1]), int(unitSpecs[2]), stateRef, projManRef, Number(unitSpecs[3]),100,AlienNormalTexture));
								break;
							case 2 : 
								addEnemy(new ScatterEnemyShip(int(unitSpecs[1]), int(unitSpecs[2]), stateRef, projManRef, Number(unitSpecs[3]),100,ScatterAlienShipTextureClass));
								break;
							case 3 : 
								addEnemy(new TankEnemyShip(int(unitSpecs[1]), int(unitSpecs[2]), stateRef, projManRef, Number(unitSpecs[3]),100,TankAlienShipTextureClass));
								break;
							case 4 : 
								addEnemy (new MoverAlienShip(int(unitSpecs[1]), int(unitSpecs[2]), stateRef, projManRef, Number(unitSpecs[3]),100,MoverAlienShipTextureClass,new Array(new FlxPoint(unitSpecs[5],unitSpecs[6]),new FlxPoint(unitSpecs[7],unitSpecs[8]),new FlxPoint(unitSpecs[9],unitSpecs[10]),new FlxPoint(unitSpecs[11],unitSpecs[12])),150));
								break;
							case 5 : 
								addEnemy(new Asteroid(int(unitSpecs[1]), int(unitSpecs[2]), stateRef, projManRef, Number(unitSpecs[3]),100,asteroidTexture));
								break;
							case 6 : 
								addEnemy(new HunterUFO(int(unitSpecs[1]), int(unitSpecs[2]), stateRef, projManRef, Number(unitSpecs[3]),100,HunterAlienShipTextureClass,turretManager));
								break;
						}
						
					}
				}
				
				var path : Array = new Array(new FlxPoint(100, 100), new FlxPoint(400, 100), new Point(400, 200), new Point(100, 200));
	
				HUD.waveNumber = waveNumber;
			}
			
		}
		
		public function update():void
		{
			if (waveComplete.x > - 1000)
			{
				waveComplete.x -= 10;
			}
			trace("Wave Complete Pos : " + waveComplete.x);
			trace(" Num : " + enemies.countLiving()); 
			for (var i :int = 0; i < enemies.countLiving(); i++)
			{
				if (enemies.members[i].y > 500)
				{
					enemies.members[i].kill();
					removeEnemy(i);
					i--;
				}
			}
			if (enemies.countLiving() < 1)
			{
				currentWave++;
				loadWave(currentWave);
				MedalManager.wavesCompleted++;
			}
		}
		
		//} endregion
		
		//{ region Add/Remove Projectiles
		public function collisionDetection() : void
		{
			FlxG.collide(enemies, projManRef.getReversedProjectiles(), decHealth);
			FlxG.collide(enemies, projManRef.getTurretProj(), decHealth);
			FlxG.overlap(enemies, playerRef, bounceEnemy);
			FlxG.overlap(enemies, earth,hitEarth);
		}
		public function hitEarth(FlxObject1 : FlxObject, FlxObject2 : FlxObject) : void
		{
			earth.health -= 10;
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
			
			objectOfInterest.kill();
		}
		public function bounceEnemy(FlxObject1 : FlxObject, FlxObject2 : FlxObject) : void
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
			if (temp.fallSpeed > 0)
			{
				temp.fallSpeed *= -1;
			}
			if (temp.fallSpeed < -5)
			{
				temp.fallSpeed = -5;
			}
			temp.health -= 10;
			soundManager.playSoundEffect("bounce");
			
		}
		
		public function decHealth(FlxObject1 : FlxObject, FlxObject2 : FlxObject) : void
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
			var tempB : Bullet = otherObject as Bullet;
			projManRef.removeFromReversedProjectiles(tempB);
			projManRef.removeFromTurretProj(tempB);
			temp.health -= tempB.bulletDamage;
			tempB.kill();
		
			trace("hurt");
		}
		
		public function addEnemy(enemy:EnemyShip):void
		{
			enemies.add(enemy);
		}
		
		public function removeEnemy(index :int):void
		{
			
			if (index < enemies.length)
			{
				enemies.remove(enemies.members[index], true);
			}
		}
		
		//}
		
		//{ region Getters/Setters
		
		public function getEnemies():FlxGroup
		{
			return enemies;
		}
		
		//}
		
		public function clearEnemies():void
		{
			enemies.kill();
			enemies.clear();
			enemies.revive();
		}
	}

}