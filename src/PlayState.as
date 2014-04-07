package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "../src/Assets/background.png")] protected var BackgroundTextureClass:Class;
		//[Embed(source = "../src/Assets/pauseMenu.png")] protected var pauseTextureClass:Class;
		
		public static var background : FlxSprite; 
		private var earth : Earth;
		private var starField : StarField;
		private var playerShip : Ship;
		private var projManager : ProjectileManager;
		private var enemyManager : EnemyManager;
		private var Hud : HUD;
		private var turretSpots : FlxGroup;
		private var turretPlacer : TurretPlacer;
		private var turretHud: TurretHud;
		public var powerUpManager : PowerUpManager;
		private var powerUpHud : PowerupHud;
		private var medalManager : MedalManager;
		private var turretManager : TurretManager;
		private var soundManager : SoundManager;
		
		
		public static var extraSlot1 : Boolean = false;
		public static var extraSlot2 : Boolean = false;
		public var Paused : Boolean = true;
		
		
		public function PlayState():void
		{
			FlxG.mouse.show();
			
		}
		
		override public function create():void
		{
				Paused = false;
				
				soundManager = SoundManager.GetInstance();
				soundManager.playMusic();
				FlxG.bgColor = 0xff0c0c0c;
				FlxG.flash(0xff000000, 1);
				background = new FlxSprite(0, 0, BackgroundTextureClass);
				FlxG.worldBounds = new FlxRect(0, 0, 640, 480);
				starField = new StarField(90);
				add(starField);
				earth = new Earth(0,350,this);
				add(background);
				playerShip = new Ship( -0, 280, this);
				projManager = new ProjectileManager(this, playerShip, earth);
				turretManager = new TurretManager(this, projManager);
				
				enemyManager = new EnemyManager(this, projManager, playerShip, turretManager,earth);
				turretManager.setEnemyManager(enemyManager);
				//enemyManager.addEnemy(new EnemyShip(200, 100, this, projManager,0.1));
				enemyManager.loadWave(1);
				turretPlacer = new TurretPlacer(0, 0, this);
				turretSpots = new FlxGroup()
				add(turretSpots);
			    turretSpots.add(new TurretSpot(390, 320, this, projManager, turretPlacer, enemyManager, turretManager));
				turretSpots.add(new TurretSpot(200, 320, this, projManager, turretPlacer,enemyManager, turretManager));
				turretSpots.add(new TurretSpot(300, 320, this, projManager, turretPlacer,enemyManager, turretManager));
				
				powerUpManager = new PowerUpManager(this, playerShip);
			
				medalManager = new MedalManager();
				
				//must always be last :!!
				powerUpHud = new PowerupHud( -51, 20, this, powerUpManager, playerShip);
				turretHud = new TurretHud(0, 379, this, turretPlacer);
				Hud = new HUD(0, 0, this, turretHud);
			
				
				//
		}
		
		public function AddExtraTurretOne() : void
		{
			if (extraSlot1 == false)
			{
				turretSpots.add(new TurretSpot(100, 320, this, projManager, turretPlacer, enemyManager, turretManager));
				extraSlot1 = true;
				HUD.score-= 1000;
			}
		}
		public function AddExtraTurretTwo() : void
		{
			if (extraSlot2 == false)
			{
				turretSpots.add(new TurretSpot(500, 320, this, projManager, turretPlacer, enemyManager, turretManager));
				extraSlot2 = true;
				HUD.score-= 1000;
			}
		}
		public function HealEarth( amount : int) : void
		{
			earth.health += amount;
			FlxG.flash(0x3300ffff, .2, null, true);
			soundManager.playSoundEffect("healEarth");
		}
	
	    public function clearScreen( amount : int) : void
		{
			for (var i : int = 0; i < enemyManager.getEnemies().members.length; i++)
			{
				if (enemyManager.getEnemies().members[i] != null)
				{
					if (enemyManager.getEnemies().members[i].y > 0)
					{
						enemyManager.getEnemies().members[i].health -= amount;
					}
				}
			}
			FlxG.flash(0x33ff0000, .2, null, true);
			soundManager.playSoundEffect("clearScreen");
		}
		
		override public function update():void
		{
			
			if (earth.health < 0)
			{
				FlxG.switchState(new EndScreen(HUD.waveNumber, HUD.score));
			}
			background.fill(0x000c0c0c);
			if (turretPlacer != null)
			{
				turretPlacer.goRed(false);
			}
			super.update();
			projManager.update();
			enemyManager.update();
			powerUpManager.Update();
			medalManager.update();
			collisionDetection();
			
			if (turretPlacer.getPlacingTurret() && FlxG.mouse.y < turretHud.y)
			{
				if (FlxG.mouse.justPressed() && !overTurretSport())
				{
					turretPlacer.place();
					Hud.addToScore(turretPlacer.getTurretCost());
				}
			}
		
		}
		
		public function collisionDetection () :void
		{
			projManager.collisionDetection();
			enemyManager.collisionDetection();
			turretManager.collisionDetection();
		}
		
		public function overTurretSport():Boolean
		{
			var mouseRect :FlxRect = new FlxRect(turretPlacer.x, turretPlacer.y, turretPlacer.width, turretPlacer.height);
			var overlaps :Boolean = false;
			for (var i:int = 0; i < turretSpots.length; i++)
			{
				if (mouseRect.overlaps(new FlxRect(turretSpots.members[i].x, turretSpots.members[i].y, turretSpots.members[i].width, turretSpots.members[i].height)))
				{
					overlaps = true;
				}
			}
			return overlaps;
		}
		
	}
}