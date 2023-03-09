package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;
import flixel.input.gamepad.FlxGamepad;

class InstructionsState extends FlxState {

	var doors:FlxSprite;
	var e:FlxSprite;
	var text2:FlxText;

	override public function create()
	{
		super.create();

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		e = new FlxSprite(0,0);
	    e.frames = FlxAtlasFrames.fromSparrow('assets/images/door.png', 'assets/images/door.xml');
	    e.animation.addByPrefix('doorshut', 'doorshut', 24, false);
	    e.animation.play("doorshut");
	    add(e);

		doors = new FlxSprite(0,0);
		if (gamepad == null) {
			doors.loadGraphic("assets/images/Mouse_Left_Key_Dark.png");
		}else {
			doors.loadGraphic("assets/images/ps4.png");
		}
	    
	    doors.screenCenter();
	    doors.y -= 60;
	    add(doors);

	    text2 = new FlxText(0,0,0,"Move and click",50);
		text2.screenCenter();
		add(text2);

		var soundtimer = new FlxTimer();

		soundtimer.start(3, function(t:FlxTimer) {
			FlxG.switchState(new GameState("null"));
		}, 1);
		
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
		if (gamepad == null) {
			doors.loadGraphic("assets/images/Mouse_Left_Key_Dark.png");
		}else {
			doors.loadGraphic("assets/images/ps4.png");
		}

		doors.screenCenter();
	    doors.y -= 60;
		
	}
}