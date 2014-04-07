package 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author Joseph Bentley
	 */
	public class TrailRenderer 
	{
		
		private var num : int = 0;
		public var trail : FlxGroup;
		private var followRef : FlxSprite;
		public function TrailRenderer(level : FlxState,followRef : FlxSprite,TrailTexture : Class) 
		{
			trail = new FlxGroup(21);
			this.followRef = followRef;
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			trail.add(new FlxSprite(0, 0, TrailTexture));
			for (var i :int = 0; i < trail.members.length - 1; i ++)
			{
				if (trail.members[i].alpha > .5)
				{
					//trail.members[i].color = 0x803300;
					trail.members[i].alpha = .1;
					
				}
			}
			
			level.add(trail);
		}
		public function Update(rotation : Number) : void
		{
			trail.members[num].x = followRef.x  ;
			trail.members[num].y = followRef.y ;
			trail.members[num].angle = rotation;
			num++;
			if (num > trail.members.length-2)
			{
				num = 0;
			}
		}
	}

}