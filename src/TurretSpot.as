package  
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxButton;
	import org.flixel.FlxRect;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.plugin.photonstorm.FlxExtendedSprite
	/**
	 * ...
	 * @author ...
	 */
	public class TurretSpot extends FlxExtendedSprite
	{
		[Embed(source = "../src/Assets/placementRect.png")] protected var TurretSpotTextureClass:Class;
		[Embed(source = "../src/Assets/BasicTurretHead.png")] protected var basicTurretHeadTex:Class;
		[Embed(source = "../src/Assets/AdvancedTurretHead.png")] protected var advancedTurretHeadTex:Class;
		[Embed(source = "../src/Assets/turretHead.png")] protected var turretHeadTex:Class;
		[Embed(source = "../src/Assets/scatterShotHead.png")] protected var ScatterTurretHeadTex:Class;
		[Embed(source = "../src/Assets/LazerHead.png")] protected var LaserTurretHeadTex:Class;
		[Embed(source = "../src/Assets/ReflectHead.png")] protected var ReflectTurretHeadTex:Class;
		
		
		private var hasTurret :Boolean;
		private var turretLevel :int
		private var turret :Turret;
		private var stateRef :FlxState;
		private var projManRef :ProjectileManager;
		private var normalTurretTexture : Array = new Array();
		private var scatterTurretTexture : Array = new Array();
		private var LaserTurretTexture : Array = new Array();
		private var ReflectTurretTexture : Array = new Array();
		private var turretPlacerRef :TurretPlacer;
		private var enemyManager : EnemyManager;
		private var upgradeButton : FlxButton;
		private var repairButton : FlxButton;
		private var destroyButton : FlxButton;
		private var upgradeMode :Boolean;
		private var mouseReleased :Boolean;
		private var turretCost :int;
		private var turretType :int;
		private var turretManagerRef :TurretManager;
		public static var normalCost : Array = new Array();
		public static var scatterCost : Array = new Array();
		public static var lazerCost : Array = new Array();
		public static var reflectCost : int;
		
		public function TurretSpot(x :int , y : int, state : FlxState, projManRef:ProjectileManager, turretPlacerRef :TurretPlacer,enemyManager : EnemyManager, turretManager :TurretManager) 
		{
			super(x, y, TurretSpotTextureClass);
			this.enemyManager = enemyManager;
			
			normalTurretTexture.push(basicTurretHeadTex);
			normalTurretTexture.push(turretHeadTex);
			normalTurretTexture.push(advancedTurretHeadTex);
			
			scatterTurretTexture.push(ScatterTurretHeadTex);//pushing it three times because we only have 1 texture...for now
			scatterTurretTexture.push(ScatterTurretHeadTex);
			scatterTurretTexture.push(ScatterTurretHeadTex);
			
			LaserTurretTexture.push(LaserTurretHeadTex);
			LaserTurretTexture.push(LaserTurretHeadTex);
			LaserTurretTexture.push(LaserTurretHeadTex);
			
			ReflectTurretTexture.push(ReflectTurretHeadTex);
			
			this.health = 100;
			state.add(this);
			hasTurret = false;
			turretLevel = 0;
			stateRef = state;
			this.projManRef = projManRef;
			this.turretPlacerRef = turretPlacerRef;
			repairButton = new FlxButton(x - 16, y - 44, "Repair", repairTurret);
			upgradeButton = new FlxButton(x - 16, y - 66, "Upgrade", upgradeTurret);
			destroyButton = new FlxButton(x - 16, y - 22, "Destroy", destroyTurret);
			upgradeButton.kill();
			destroyButton.kill();
			repairButton.kill();
			mouseReleased = true;
			turretCost = 0;
			turretType = 0;
			turretManagerRef = turretManager;
			
			normalCost.push(100);
			normalCost.push(500);
			normalCost.push(2000);
			
			scatterCost.push(500);
			scatterCost.push(800);
			scatterCost.push(1500);
			
			lazerCost.push(1500);
			lazerCost.push(2000);
			lazerCost.push(5000);
			
			reflectCost = 500;
		}
		
		public override function update():void
		{
			super.update();
			
			if (hasTurret)
			{
				if (!turret.alive)
				{
					hasTurret = false;
					stateRef.remove(turret);
					turretManagerRef.removeTurret(turret);
					this.visible = true;
				}
			}
		
			
			if (turretPlacerRef.getPlacingTurret())
			{
				var mouseRect:FlxRect = new FlxRect(turretPlacerRef.x, turretPlacerRef.y, turretPlacerRef.width, turretPlacerRef.height);
				if (mouseRect.overlaps(new FlxRect(x, y, width, height)))
				{
					if (hasTurret)
					{
						turretPlacerRef.goRed(true);
					}
					else if (FlxG.mouse.justPressed())
					{
						mouseReleased = false;
						turretPlacerRef.place();
						placeTurret(turretPlacerRef.getType(), turretPlacerRef.getLevel());
						MedalManager.moneySpent += turretPlacerRef.getTurretCost();
					}
				}
			}
			else if(mouseReleased)
			{
				if (this.mouseOver && FlxG.mouse.justPressed() && hasTurret)
				{
					if (!upgradeMode)
					{
						if (turretLevel < 3)
						{
							upgradeButton.exists = true;
							stateRef.add(upgradeButton);
						}
						destroyButton.exists = true;
						repairButton.exists = true;
						stateRef.add(destroyButton);
						stateRef.add(repairButton);
						upgradeMode = true;
						FlxG.timeScale = 0;
						mouseReleased = false;
					}
					else
					{
						mouseReleased = false;
						upgradeMode = false;
						FlxG.timeScale = 1;
						upgradeButton.kill();
						destroyButton.kill();
						repairButton.kill();
						stateRef.remove(upgradeButton);
						stateRef.remove(destroyButton);
						stateRef.remove(repairButton);
					}
				}
			}
			else
			{
				mouseReleased = !FlxG.mouse.pressed();
			}
		}
		
		public function placeTurret(turretType:int, turretLevel:int):void
		{
			this.visible = false;
			stateRef.remove(turret);
			this.turretType = turretType;
			this.turretLevel = turretLevel;
			
			if (turret != null)
			{
				turret.kill();
				turretManagerRef.removeTurret(turret);
			}
			switch(turretType)
			{
				case 1:
					if (turretLevel == 3)
					{
						MedalManager.fullTurret = true;
					}
					turret = new Turret(x, y, stateRef, projManRef, normalTurretTexture, enemyManager, turretLevel - 1);
					turretCost = normalCost[turretLevel - 1];
				break;
				case 2:
					if (turretLevel == 3)
					{
						MedalManager.fullScatter = true;
					}
					turret = new ScatterShotTurret(x, y, stateRef, projManRef, scatterTurretTexture, turretLevel - 1);
					turretCost = scatterCost[turretLevel - 1];
				break;
				case 3:
					if (turretLevel == 3)
					{
						MedalManager.fullLazer = true;
					}
					turret = new FrikenLazer(x, y, stateRef, projManRef, LaserTurretTexture, enemyManager, turretLevel - 1);
					turretCost = lazerCost[turretLevel - 1];
				break;
			case 4:
				{
					turret = new ReflectTurret(x, y, stateRef, projManRef, ReflectTurretTexture, enemyManager, turretLevel - 1);
				}
			}
			turretManagerRef.addTurret(turret);
			hasTurret = true;
		}
		
		public function upgradeTurret():void
		{
			if (hasTurret)
			{
				if (!turret.alive)
				{
					hasTurret = false;
					//turret.kill();
					stateRef.remove(turret);
					turretManagerRef.removeTurret(turret);
					this.visible = true;
				}
			}
			
			mouseReleased = false;
			var cost :int = 0;
			switch(turretType)
			{
				case 1:
					cost = normalCost[turretLevel] / 2;
					break;
				case 2:
					cost = scatterCost[turretLevel] / 2;
					break;
				case 3:
					cost = lazerCost[turretLevel] / 2;
					break;
			}
			
			if (HUD.score >= cost)
			{
				if (turretLevel == 2)
				{
					switch(turretType)
					{
						case 1:
							MedalManager.fullTurret = true;
							break;
						case 2:
							MedalManager.fullScatter = true;
							break;
						case 3:
							MedalManager.fullLazer = true;
							break;
					}
				}
			
				upgradeMode = false;
				FlxG.timeScale = 1;
				stateRef.remove(turret);
				turretManagerRef.removeTurret(turret);
				turret.kill();
				HUD.score -= cost;
				upgradeButton.kill();
				destroyButton.kill();
				repairButton.kill();
				stateRef.remove(upgradeButton);
				stateRef.remove(destroyButton);
				stateRef.remove(repairButton);
				turretLevel++;
				switch(turretType)
				{
					case 1:
						turretCost = normalCost[turretLevel - 1];
					break;
					case 2:
						turretCost = scatterCost[turretLevel - 1];
					break;
					case 3:
						turretCost = lazerCost[turretLevel - 1];
					break;
				}
				
				switch(turretType)
				{
					case 1:
							turret = new Turret(x, y, stateRef, projManRef, normalTurretTexture, enemyManager, turretLevel - 1);
					break;
					case 2:
						if (turretLevel == 3)
						{
							MedalManager.fullScatter = true;
						}
						turret = new ScatterShotTurret(x, y, stateRef, projManRef, scatterTurretTexture, turretLevel - 1);
					break;
					case 3:
						if (turretLevel == 3)
						{
							MedalManager.fullLazer = true;
						}
						turret = new FrikenLazer(x, y, stateRef, projManRef, LaserTurretTexture, enemyManager, turretLevel - 1);
					break;
				}
				turretManagerRef.addTurret(turret);
			}
		}
		
		public function repairTurret():void
		{
			HUD.score-= 100 - turret.health;
			turret.health = 100;
		}
		
		public function destroyTurret():void
		{
			upgradeMode = false;
			FlxG.timeScale = 1;
			mouseReleased = false;
			upgradeButton.kill();
			destroyButton.kill();
			repairButton.kill();
			stateRef.remove(upgradeButton);
			stateRef.remove(destroyButton);
			stateRef.remove(repairButton);
			hasTurret = false;
			HUD.score += turretCost / 2;
			turret.kill();
			stateRef.remove(turret);
			turretManagerRef.removeTurret(turret);
			this.visible = true;
		}
		
	}

}