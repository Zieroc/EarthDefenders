package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	public class HUD  extends FlxSprite
	{
		[Embed(source = "../src/Assets/Hud.png")] protected var HudTextureClass:Class;
		
		private var scoreText : FlxText;
		private var waveNumberText : FlxText;
		public static var score : int = 0;
		public static var waveNumber : int = 1;
		private var turretHud : TurretHud;
		public function HUD(x : int, y : int, state : FlxState,turretHud : TurretHud)
		{
			super(x, y, HudTextureClass);
			this.turretHud = turretHud;
			state.add(this);
			scoreText = new FlxText(20, 10, 300, "Money : " + score);
			waveNumberText = new FlxText(350, 10, 300, "Wave : " + waveNumber);
			state.add(scoreText);
			state.add(waveNumberText);
			scoreText.size = 16;
			waveNumberText.size = 16;
			
		}
		public function getScore() : int
		{
			return score;
		}
		public function addToScore(amount : int) : void
		{
			score += amount;
		}
		override public function update():void 
		{
			scoreText.text = "Money : " + score;
			waveNumberText.text = "Wave : " + waveNumber;
			this.y = turretHud.y - 19;
			scoreText.y = this.y ;
			waveNumberText.y = this.y;
			super.update();
		}
	}

}