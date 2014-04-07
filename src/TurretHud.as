package  
{
	import org.flixel.FlxButton;
	import org.flixel.FlxPoint;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FlxExtendedSprite;
	/**
	 * ...
	 * @author Christy Carroll
	 */
	public class TurretHud extends FlxExtendedSprite
	{
		[Embed(source = "../src/Assets/SelectionHud.png")] protected var TurretHudTex:Class;
		[Embed(source = "../src/Assets/BasicTurretHead.png")] protected var basicTurretHeadTex:Class;
		[Embed(source = "../src/Assets/AdvancedTurretHead.png")] protected var advancedTurretHeadTex:Class;
		[Embed(source = "../src/Assets/turretHead.png")] protected var turretHeadTex:Class;
		[Embed(source = "../src/Assets/scatterShotHead.png")] protected var ScatterTurretHeadTex:Class;
		[Embed(source = "../src/Assets/LazerHead.png")] protected var LaserTurretHeadTex:Class;
		[Embed(source = "../src/Assets/ReflectHead.png")] protected var ReflectTurretHeadTex:Class;
		
		private var turretPlacerRef :TurretPlacer;
		private var stateRef :FlxState
		private var normalTurretTexture : Array = new Array();
		private var scatterTurretTexture : Array = new Array();
		private var LaserTurretTexture : Array = new Array();
		private var toggleButton : FlxButton;
		public static var open : Boolean =  false;
		private var openPos : FlxPoint = new FlxPoint(0, 379);
		private var closedPos : FlxPoint = new FlxPoint(0, 480);
		private var toggleButtonBool : Boolean = false;
		private var descText : FlxText;
		private var normalCost : Array = new Array();
		private var scatterCost : Array = new Array();
		private var lazerCost : Array = new Array();
		private var reflectCost : int;
		
		public function TurretHud(x :int, y :int, state :FlxState, turretPlacerRef :TurretPlacer) 
		{
			super(x, y, TurretHudTex);
			state.add(this);
			
			this.turretPlacerRef = turretPlacerRef;
			stateRef = state;
			
			normalTurretTexture.push(basicTurretHeadTex);
			normalTurretTexture.push(turretHeadTex);
			normalTurretTexture.push(advancedTurretHeadTex);
			
			scatterTurretTexture.push(ScatterTurretHeadTex);//pushing it three times because we only have 1 texture...for now
			scatterTurretTexture.push(ScatterTurretHeadTex);
			scatterTurretTexture.push(ScatterTurretHeadTex);
			
			LaserTurretTexture.push(LaserTurretHeadTex);
			LaserTurretTexture.push(LaserTurretHeadTex);
			LaserTurretTexture.push(LaserTurretHeadTex);
			
			toggleButton = new FlxButton(550, 460, "Hide/Show [s]", toggleMenu)
			descText = new FlxText(x + 10, y + 50, 600, "")
			descText.size = 16;
			descText.color = 0xff000000;
			state.add(descText);
			state.add(toggleButton);
			
			normalCost.push(TurretSpot.normalCost[0]);
			normalCost.push(TurretSpot.normalCost[1]);
			normalCost.push(TurretSpot.normalCost[2]);
			
			scatterCost.push(TurretSpot.scatterCost[0]);
			scatterCost.push(TurretSpot.scatterCost[1]);
			scatterCost.push(TurretSpot.scatterCost[2]);
			
			lazerCost.push(TurretSpot.lazerCost[0]);
			lazerCost.push(TurretSpot.lazerCost[1]);
			lazerCost.push(TurretSpot.lazerCost[2]);
			
			reflectCost = TurretSpot.reflectCost;
		}
		
		public static function toggleMenu() : void
		{
			if (open)
			{
				open = false;
				
				FlxG.timeScale = 1;
			}
			else
			{
				open = true;
				
				FlxG.timeScale = 0.1;
				
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			/*if (open)
			{
				FlxG.timeScale = 0.1;
			}
			else
			{
				FlxG.timeScale = 1;
			}*/
			if (FlxG.keys.S && toggleButtonBool == false)
			{
				toggleMenu();
				toggleButtonBool = true;
			}
			else if( !FlxG.keys.S)
			{
				toggleButtonBool = false;
			}
			if (open)
			{
				if (y > openPos.y)
				{
					y -= (y-openPos.y)/10;
				}
				
			}
			else
			{
				if (y < closedPos.y)
				{
					y -= (y - closedPos.y)/10;
				}
			}
			
			if (mouseOver )
			{
				if (FlxG.mouse.y > y + 3 && FlxG.mouse.y < y + 47)
				{
					if (FlxG.mouse.x > x + 4 && FlxG.mouse.x <= x + 48)
					{
						descText.text = "Normal Turret Level 1 :  Slow and not very powerfull - Cost: " + normalCost[0];
					}
					else if (FlxG.mouse.x > x + 50 && FlxG.mouse.x <= x + 94)
					{
						descText.text = "Normal Turret Level 2 :  Slight speed upgrade - Cost: " + normalCost[1];
					}
					else if (FlxG.mouse.x > x + 96 && FlxG.mouse.x <= x + 140)
					{
						descText.text = "Normal Turret Level 3 :  Rapid Speed Upgrade - Cost: " + normalCost[2];
					}
					else if (FlxG.mouse.x > x + 142 && FlxG.mouse.x <= x + 187)
					{
						descText.text = "ScatterShot Turret Level 1 : Fixed Turret that fires vertical scatters of bullets - Cost: " + scatterCost[0];
					}
					else if (FlxG.mouse.x > x + 189 && FlxG.mouse.x <= x + 234)
					{
						descText.text = "ScatterShot Turret Level 2 : Speed Updgrade - Cost: " + scatterCost[1];
					}
					else if (FlxG.mouse.x > x + 236 && FlxG.mouse.x <= x + 281)
					{
						descText.text = "ScatterShot Turret Level 3 : Rapid Fire Updgrade - Cost: " + scatterCost[2];
					}
					else if (FlxG.mouse.x > x + 284 && FlxG.mouse.x <= x + 329)
					{
						descText.text = "Friken 'Laser' Level 1 : Fires a beam of energy at the enemy causing constant damage over time - Cost: " + lazerCost[0];
					}
					else if (FlxG.mouse.x > x + 331 && FlxG.mouse.x <= x + 375)
					{
						descText.text = "Friken 'Laser' Level 2 : Wider beam for extra power - Cost: " + lazerCost[1];
					
					}
					else if (FlxG.mouse.x > x + 378 && FlxG.mouse.x <= x + 423)
					{
						descText.text = "Friken 'Laser' Level 3 : The ultimate killing machine - Cost: " + lazerCost[2];
					
					}
					else if (FlxG.mouse.x > x + 426 && FlxG.mouse.x <= x + 471)
					{
						descText.text = "Reflect Panel, reflects enemies and bullets, taking minimal damage - Cost: " + reflectCost;
					
					}
				}
			}
			
			
			toggleButton.y = y - toggleButton.height;
			descText.y = y + + 50;
			if (mouseOver && FlxG.mouse.justPressed())
			{
				if (FlxG.mouse.y > y + 3 && FlxG.mouse.y < y + 47)
				{
					if (FlxG.mouse.x > x + 4 && FlxG.mouse.x <= x + 48)
					{
						turretSelected(1, 1);
					}
					else if (FlxG.mouse.x > x + 50 && FlxG.mouse.x <= x + 94)
					{
						turretSelected(1, 2);
					}
					else if (FlxG.mouse.x > x + 96 && FlxG.mouse.x <= x + 140)
					{
						turretSelected(1, 3);
					}
					else if (FlxG.mouse.x > x + 142 && FlxG.mouse.x <= x + 187)
					{
						turretSelected(2, 1);
					}
					else if (FlxG.mouse.x > x + 189 && FlxG.mouse.x <= x + 234)
					{
						turretSelected(2, 2);
					}
					else if (FlxG.mouse.x > x + 236 && FlxG.mouse.x <= x + 281)
					{
						turretSelected(2, 3);
					}
					else if (FlxG.mouse.x > x + 284 && FlxG.mouse.x <= x + 329)
					{
						turretSelected(3, 1);
					}
					else if (FlxG.mouse.x > x + 331 && FlxG.mouse.x <= x + 375)
					{
						turretSelected(3, 2);
					}
					else if (FlxG.mouse.x > x + 378 && FlxG.mouse.x <= x + 423)
					{
						turretSelected(3, 3);
					}
					else if (FlxG.mouse.x > x + 426 && FlxG.mouse.x <= x + 471)
					{
						turretSelected(4, 3);
					}
				}
			}
		}
		
		public function turretSelected(turretType :int, turretLevel :int):void
		{
			switch(turretType)
			{
				case 1:
					turretPlacerRef.addTurret(normalTurretTexture[turretLevel - 1] , turretType, turretLevel, normalCost[turretLevel - 1]);
				break;
				case 2:
					turretPlacerRef.addTurret(scatterTurretTexture[turretLevel - 1] , turretType, turretLevel, scatterCost[turretLevel - 1]);
				break;
				case 3:
					turretPlacerRef.addTurret(LaserTurretTexture[turretLevel - 1] , turretType, turretLevel, lazerCost[turretLevel - 1]);
				break;
				case 4:
					turretPlacerRef.addTurret(ReflectTurretHeadTex , turretType, turretLevel, reflectCost);
				break;
			}
			open = false;
			FlxG.timeScale = 1;
		}
	}

}