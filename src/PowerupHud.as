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
	public class PowerupHud extends FlxExtendedSprite
	{
		[Embed(source = "../src/Assets/powerupBar.png")] protected var PowerupHudTex:Class;
		
		private var powerUpManagerRef :PowerUpManager;
		private var playerRef :Ship;
		private var toggleButton : FlxButton;
		private var open : Boolean =  false;
		private var openPos : FlxPoint = new FlxPoint(0, 20);
		private var closedPos : FlxPoint = new FlxPoint(-51, 20);
		private var toggleButtonBool : Boolean = false;
		private var descText : FlxText;
		private var stateRef : FlxState;
		public function PowerupHud(x :int, y :int, state :FlxState, powerUpManagerRef :PowerUpManager, playerRef:Ship) 
		{
			super(x, y, PowerupHudTex);
			state.add(this);
			
			this.powerUpManagerRef = powerUpManagerRef;
			this.playerRef = playerRef;
			
			toggleButton = new FlxButton(10, 10, "Hide/Show [Q]", toggleMenu)
			descText = new FlxText(0, 0, 150, "Ohh Herro thar!!");
			state.add(toggleButton);
			state.add(descText);
			stateRef = state;
		}
		
		public function toggleMenu() : void
		{
			if (this.open)
			{
				open = false;
				
			}
			else
			{
				open = true;
			}
		}
		
		override public function update():void 
		{
			super.update();
			descText.x = FlxG.mouse.x + 20;
			descText.y = FlxG.mouse.y + 10;
			if (FlxG.keys.Q && toggleButtonBool == false)
			{
				toggleMenu();
				toggleButtonBool = true;
			}
			else if( !FlxG.keys.Q)
			{
				toggleButtonBool = false;
			}
			if (open)
			{
				if (x < openPos.x)
				{
					x -= (x-openPos.x)/10;
				}
				
			}
			else
			{
				if (x > closedPos.x)
				{
					x -= (x - closedPos.x)/10;
				}
			}
			
			toggleButton.y = y - toggleButton.height;
			
			if (mouseOver)
			{
				if (FlxG.mouse.x > x + 4 && FlxG.mouse.x <= x + 36)
				{
					if (FlxG.mouse.y > y + 4 && FlxG.mouse.y <= y + 36)
					{
						descText.text = "HEAL Level 1 :Heal Earth by 25 units - cost : 500";
					}
					else if (FlxG.mouse.y > y + 40 && FlxG.mouse.y <= y + 74)
					{
						descText.text = "HEAL Level 2 :Heal Earth by 50 units - cost : 800";
					}
					else if (FlxG.mouse.y > y + 77 && FlxG.mouse.y <= y + 111)
					{
						descText.text = "Clear Screen Level 1 :Damage all units onscreen by 20 - cost : 1000";
					}
					else if (FlxG.mouse.y > y + 116 && FlxG.mouse.y <= y + 149)
					{
						descText.text = "Clear Screen Level 2 :Damage all units onscreen by 60 - cost : 2000";
					}
					else if (FlxG.mouse.y > y + 152 && FlxG.mouse.y <= y + 184)
					{
						descText.text = "Clear Screen Level 3 :Damage all units onscreen by 100 - cost : 3000";
					}
					else if (FlxG.mouse.y > y + 188 && FlxG.mouse.y <= y + 220)
					{
						descText.text = "Extra Turret Spot 1 :Unlock a spot for an extra turret - cost : 1000";
						if (PlayState.extraSlot1 == true)
						{
							descText.text = "Extra Turret Spot 1 :Unlock a spot for an extra turret - cost : [PURCHASED]";
						
						}
					}
					else if (FlxG.mouse.y > y + 223 && FlxG.mouse.y <= y + 255)
					{
						descText.text = "Extra Turret Spot 2 :Unlock a spot for an extra turret - cost : 1000"
						if (PlayState.extraSlot2 == true)
						{
							descText.text = "Extra Turret Spot 2 :Unlock a spot for an extra turret - cost : [PURCHASED]";
						
						}
					}
				}
			}
			else
			{
				descText.text = "";
			}
			if (mouseOver && FlxG.mouse.justPressed())
			{
				if (FlxG.mouse.x > x + 4 && FlxG.mouse.x <= x + 36)
				{
					if (FlxG.mouse.y > y + 4 && FlxG.mouse.y <= y + 36)
					{
						if (HUD.score >= 500)
						{
							HUD.score -= 500;
							MedalManager.moneySpent += 500;
							powerupSelected(0);
						}
					}
					else if (FlxG.mouse.y > y + 40 && FlxG.mouse.y <= y + 74)
					{
						if (HUD.score >= 800)
						{
							HUD.score -= 800;
							MedalManager.moneySpent += 800;
							powerupSelected(1);
						}
					}
					else if (FlxG.mouse.y > y + 77 && FlxG.mouse.y <= y + 111)
					{
						if (HUD.score >= 1000)
						{
							HUD.score -= 1000;
							MedalManager.moneySpent += 1000;
							powerupSelected(2);
						}
					}
					else if (FlxG.mouse.y > y + 116 && FlxG.mouse.y <= y + 149)
					{
						if (HUD.score >= 2000)
						{
							HUD.score -= 2000;
							MedalManager.moneySpent += 2000;
							powerupSelected(3);
						}
					}
					else if (FlxG.mouse.y > y + 152 && FlxG.mouse.y <= y + 184)
					{
						if (HUD.score >= 3000)
						{
							HUD.score -= 3000;
							MedalManager.moneySpent += 3000;
							powerupSelected(4);
						}
					}
					else if (FlxG.mouse.y > y + 188 && FlxG.mouse.y <= y + 220)
					{
						if (HUD.score >= 1000)
						{
							HUD.score -= 0;
							MedalManager.moneySpent += 1000;
							var world : PlayState = stateRef as PlayState;
							world.AddExtraTurretOne();
							
						}
					}
					else if (FlxG.mouse.y > y + 223 && FlxG.mouse.y <= y + 255)
					{
						if (HUD.score >= 1000)
						{
							HUD.score -= 0;
							MedalManager.moneySpent += 1000;
							var world2 : PlayState = stateRef as PlayState;
							world2.AddExtraTurretTwo();
						}
					}
					
				}
			}
		}
		
		public function powerupSelected(type :int):void
		{
			var powerUp :PowerUp = new PowerUp(playerRef.x + 20, playerRef.y - 50, type)
			powerUp.visible = false;
			powerUpManagerRef.AddPowerUp(powerUp);
			open = false;
		}
	}

}