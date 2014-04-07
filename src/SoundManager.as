package  
{
	import flash.media.Sound;
	import org.flixel.*;
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	public class SoundManager 
	{
		[Embed(source = "/Assets/LevelLoop.mp3")] 	public var MusicSpace:Class;
		[Embed(source="/Assets/MenuLoop.mp3")] 	public var MenuMusic:Class;
		
		[Embed(source="/Assets/AlienBlaster.mp3")] 	public var AlienBlaster:Class;
		[Embed(source="/Assets/GunShot.mp3")] 	public var GunShot:Class;
		[Embed(source="/Assets/bounce.mp3")] 	public var bounce:Class;
		[Embed(source="/Assets/ShotGun.mp3")] public var shotgunPew:Class;
		[Embed(source="/Assets/Hum.mp3")] public var lazer:Class;
		[Embed(source="/Assets/ClearScreen.mp3")] public var clearScreen:Class;
		[Embed(source="/Assets/Heal.mp3")] public var HealEarth:Class;
		
		private var humSound : FlxSound;
		public static var me : SoundManager;
		
		public function SoundManager() 
		{
				
		
		}
		
		public static function GetInstance() : SoundManager
		{
			if (me == null)
			{
				me = new SoundManager();
			}
			return me;
		}
		
		public function playMusic() : void
		{
			FlxG.playMusic(MusicSpace,.1);
		}
		public function playMenu() : void
		{
			FlxG.playMusic(MenuMusic);
		}
		public function stopMusic() : void
		{
			FlxG.music.stop();
		}
		public function playSoundEffect(sound : String) : void
		{
			
				if (sound == "alien blaster")
				{
					FlxG.play(AlienBlaster, .5, false, true);
				}
				else if (sound == "gun shot")
				{
					FlxG.play(GunShot, .5, false, true);
				}
				else if (sound == "bounce")
				{
					FlxG.play(bounce, .5, false, true);
				}
				else if (sound == "shotGun")
				{
					FlxG.play(shotgunPew, .03, false, true);
				}
				else if (sound == "clearScreen")
				{
					FlxG.play(clearScreen, .4, false, true);
				}
				else if (sound == "healEarth")
				{
					FlxG.play(HealEarth, .4, false, true);
				}
		}
		public function playShotGun() : void
		{
			FlxG.play(GunShot, .1, false, true);
		}
		public function laserHum() : void
		{
			if (humSound == null)
			{
				humSound = new FlxSound();
				humSound.loadEmbedded(lazer, false, false);
				humSound.volume = .1;
			}
			
			humSound.play();
			
		}
	}

}