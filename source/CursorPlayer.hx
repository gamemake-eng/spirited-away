package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.input.gamepad.FlxGamepad;

class CursorPlayer extends FlxSprite {
	
	public var mouseispressed:Bool;

	public function new(x:Float,y:Float)
	{
	    super(x,y);
	    var tex = FlxAtlasFrames.fromSparrow('assets/images/player.png', 'assets/images/player.xml');
		frames = tex;

		animation.addByPrefix('normal', 'normal', 24, true);
		animation.addByPrefix('click', 'click', 24, false);
		animation.addByPrefix('over', 'over', 24, false);
		animation.play('normal');

		screenCenter();
		
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
		
		if (FlxG.mouse.justPressed || (gamepad != null && gamepad.justPressed.A)) {
			mouseispressed = true;
		}else {
			mouseispressed = false;
		}

		FlxG.mouse.visible = false;

		if (gamepad == null) {
			x=FlxG.mouse.x;
			y=FlxG.mouse.y;
		} else {
			var up:Bool = gamepad.pressed.LEFT_STICK_DIGITAL_UP || gamepad.pressed.DPAD_UP;
			var down:Bool = gamepad.pressed.LEFT_STICK_DIGITAL_DOWN || gamepad.pressed.DPAD_DOWN;
			var left:Bool = gamepad.pressed.LEFT_STICK_DIGITAL_LEFT || gamepad.pressed.DPAD_LEFT;
			var right:Bool = gamepad.pressed.LEFT_STICK_DIGITAL_RIGHT || gamepad.pressed.DPAD_RIGHT;

			if (up) {
				velocity.y = -200;
			}
			if (down) {
				velocity.y = 200;
			}
			if (left) {
				velocity.x = -200;
			}
			if (right) {
				velocity.x = 200;
			}

			if (!(up || down)) {
				velocity.y = 0;
			}
			if (!(left || right)) {
				velocity.x = 0;
			}
		}
		
	}
}