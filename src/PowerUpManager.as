package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	public class PowerUpManager 
	{
		private var powerUps : FlxGroup = new FlxGroup(10);
		private var state : FlxState;
		private var playerRef : Ship;
		public function PowerUpManager(state : FlxState,player : Ship) 
		{
			this.state = state;
			this.playerRef = player;
		}
		
		public function AddPowerUp(powerUp : PowerUp) : void
		{
			state.add(powerUp);
			powerUps.add(powerUp);
		}
		public function GetPowerUps() : FlxGroup
		{
			return powerUps;
		}
		public function Update() : void
		{
			FlxG.collide(playerRef, powerUps,HandlePowerUp)	
		}
		public function HandlePowerUp(FlxObject1 : FlxObject, FlxObject2 : FlxObject) : void
		{
			
			var objectOfInterest : FlxObject;
			var otherObject : FlxObject;
			if (FlxObject1 is PowerUp)
			{
				objectOfInterest = FlxObject1;
				otherObject = FlxObject2;
			}
			else
			{
				objectOfInterest = FlxObject2;
				otherObject = FlxObject1;
			}
			var temp : PowerUp = objectOfInterest as PowerUp; 
			var world : PlayState = state as PlayState;
			switch(temp.type)
			{
				case 0 : world.HealEarth(10); break; //heal earth 10%
				case 1 : world.HealEarth(25); MedalManager.healedWorld = true; break; //heal earth 25%;
				case 2 : world.clearScreen(20); break; //clear screen 20
				case 3 : world.clearScreen(60); break; //clear screen 60
				case 4 : world.clearScreen(100); MedalManager.clearedScreen = true;  break; //clear screen 20
			}
			temp.kill();
			powerUps.remove(temp);
		}
	}

}