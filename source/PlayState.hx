package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.graphics.frames.FlxAtlasFrames;

class PlayState extends FlxState
{
	var doors:FlxSprite;
	var text2:FlxText;
	override public function create()
	{
		super.create();
		doors = new FlxSprite(0,0);
	    doors.frames = FlxAtlasFrames.fromSparrow('assets/images/door.png', 'assets/images/door.xml');
	    doors.animation.addByPrefix('doorshut', 'doorshut', 24, false);
	    doors.animation.play("doorshut");
	    add(doors);

	    text2 = new FlxText(0,0,0,"Click to start",50);
		text2.screenCenter();
		add(text2);
		
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.mouse.pressed) {
			FlxG.switchState(new InstructionsState());
		}
		
	}
}
