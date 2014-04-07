package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Christy Carroll
	 */
	public class TurretPlacer extends FlxSprite
	{
		[Embed(source = "../src/Assets/turretMounting.png")] protected var turretMountTex:Class;
		[Embed(source = "../src/Assets/BasicTurretHead.png")] protected var basicTurretHeadTex:Class;
		
		private var placingTurret :Boolean;
		private var turretType :int;
		private var turretLevel :int;
		private var mountSprite : FlxSprite;
		private var turretCost : int;
		private var stateRef : FlxState;
		
		
		public function TurretPlacer(x :int, y :int,  state :FlxState)
		{
			super(x, y);
			mountSprite = new FlxSprite(x + 4, y + 10, turretMountTex);
			alpha = 0.6;
			stateRef = state;
		}
		
		public function addTurret(graphic :Class, turretType :int, turretLevel :int, turretCost :int):void
		{
			if (HUD.score >= turretCost)
			{
				loadGraphic(graphic);
				placingTurret = true;
				this.turretType = turretType;
				this.turretLevel = turretLevel;
				revive();
				stateRef.add(this);
				stateRef.add(mountSprite);
				FlxG.mouse.hide();
				this.turretCost = turretCost;
				HUD.score -= turretCost;
			}
		}
		
		public override function update():void
		{
			super.update();
			if (placingTurret)
			{
				if (FlxG.keys.W)
				{
					HUD.score += turretCost;
					place();
				}
				moveTo(FlxG.mouse.x, FlxG.mouse.y);
			}
		}
		
		public function place():void
		{
			placingTurret = false;
			stateRef.remove(this);
			stateRef.remove(mountSprite);
			kill();
			moveTo( -100, -100);
			FlxG.mouse.show();
		}
		
		public function getPlacingTurret():Boolean
		{
			return placingTurret;
		}
		
		public function moveTo(x :int, y :int):void
		{
			this.x = x;
			this.y = y;
			mountSprite.x = x + 4;
			mountSprite.y = y + 10;
		}
		
		public function getType():int
		{
			return turretType;
		}
		
		public function getLevel():int
		{
			return turretLevel;
		}
		
		public function getTurretCost():int
		{
			return turretCost;
		}
		
		public function goRed(value :Boolean) :void
		{
			if (value)
			{
				color = FlxG.RED;
			}
			else
			{
				color = FlxG.WHITE;
			}
		}
	}

}