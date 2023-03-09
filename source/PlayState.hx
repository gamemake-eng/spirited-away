package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.input.gamepad.FlxGamepad;

class PlayState extends FlxState
{
	var doors:FlxSprite;
	var text2:FlxText;
	var textsus:FlxText;
	override public function create()
	{
		super.create();

		doors = new FlxSprite(0,0);
	    doors.frames = FlxAtlasFrames.fromSparrow('assets/images/door.png', 'assets/images/door.xml');
	    doors.animation.addByPrefix('doorshut', 'doorshut', 24, false);
	    doors.animation.play("doorshut");
	    add(doors);

		textsus = new FlxText(0,0,0,"If on controller, press X",20);
		
		add(textsus);	    

	    text2 = new FlxText(0,0,0,"Click to start",50);
		text2.screenCenter();
		add(text2);
		
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
		
		if (FlxG.mouse.pressed || (gamepad != null && gamepad.justPressed.A)) {
			FlxG.switchState(new InstructionsState());
		}
	}
}
