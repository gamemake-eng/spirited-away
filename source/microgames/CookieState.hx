package microgames;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import helpers.MicrogameState;
import flixel.graphics.frames.FlxAtlasFrames;

class CookieState extends MicrogameState {

	var cookies:Int;

	var cookiepoints:Int;

	var cookieText:FlxText;

	var cookieButton:FlxSprite;

	override public function create()
	{
		var bg = new FlxSprite(0,0);
		bg.loadGraphic("assets/images/paper.jpg");
		add(bg);

		cookiepoints = 0;
		cookies = FlxG.random.int(1,5);
		if (cookies == 1) {
			instruction = "Get " + cookies + " cookie!";
		}else {
			instruction = "Get " + cookies + " cookies!";
		}

		cookieText = new FlxText(248.2,388.9,"0",48);
		cookieText.screenCenter();
		cookieText.y=388.9;

		add(cookieText);

		cookieButton = new FlxSprite(181.7,65.8);
		cookieButton.loadGraphic("assets/images/microgames/cookie/cookie.png");
		add(cookieButton);

		super.create();
		
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if(FlxG.overlap(cursor, cookieButton) && !won) {
			if (cursor.mouseispressed && FlxG.pixelPerfectOverlap(cookieButton, cursor)) {
				cursor.animation.play('click');
				cookiepoints += 1;
			}else {
				if (FlxG.pixelPerfectOverlap(cookieButton, cursor)) {
					cursor.animation.play('over');
				}
			}
		}else {
			cursor.animation.play('normal');
		}

		if (cookiepoints == cookies) {
			won = true;
		}

		cookieText.text = Std.string(cookiepoints);
		cookieText.screenCenter();
		cookieText.y=388.9;
	}

	override public function onTimerFinished()
	{
	    FlxG.switchState(new GameState({won:won, lives:lives}));
	}
}