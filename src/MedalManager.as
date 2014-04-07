package  
{
	import com.newgrounds.API;
	/**
	 * ...
	 * @author Christy Carroll
	 */
	public class MedalManager 
	{
		
		public static var wavesCompleted :int;
		public static var moneySpent: int;
		public static var fullTurret: Boolean;
		public static var fullScatter: Boolean;
		public static var fullLazer: Boolean;
		public static var healedWorld: Boolean;
		public static var earthDestroyed: Boolean;
		public static var clearedScreen: Boolean;
		
		
		public function MedalManager() 
		{
			wavesCompleted = 0;
			moneySpent = 0;
			fullTurret = false;
			fullScatter = false;
			fullLazer = false;
		}
		
		public function update():void
		{
			//Level 3 Turret Medals
			if (fullTurret)
			{
				unlock("Fish in a Barrel");
			}
			if (fullScatter)
			{
				unlock("You call that a gun? This is a gun!");
			}
			if (fullLazer)
			{
				unlock("Ima Firin mah Lazer");
			}
			
			//Power Up Medals
			if (healedWorld)
			{
				unlock("Heeeal the woooorld");
			}
			
			if (clearedScreen)
			{
				unlock("Resorting to Nukes");
			}
			
			if (earthDestroyed)
			{
				unlock("You Maniacs! You blew it up!");
			}
			
			//Wave Medals
			if (wavesCompleted == 1)
			{
				unlock("Invaders Gonna Invade!");
			}
			else if (wavesCompleted == 5)
			{
				unlock("Protectors Gonna Protect!");
			}
			else if (wavesCompleted == 10)
			{
				unlock("Defenders Gonna Defend!");
			}
			else if (wavesCompleted == 20)
			{
				unlock("Invaders Gonna Keep Invading!");
			}
			
			//Money Medals
			/*if (HUD.score >= 1500)
			{
				unlock("ScoreMedalsWorking");
			}
			if (moneySpent >= 500)
			{
				unlock("SpentMedalWorking");
			}*/
		}
		
		public function unlock(name:String):void
		{
			if (!API.getMedal(name).unlocked)
			{
				API.unlockMedal(name);
			}
		}
		
		public static function postScore():void
		{
			var score:int = HUD.score * wavesCompleted;
			API.postScore("High Scores", score);
		}
		
	}

}