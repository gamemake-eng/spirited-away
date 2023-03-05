package microgames;

import helpers.MicrogameState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;

class SusState extends MicrogameState {

	var pic:FlxSprite;

	var yes:FlxSprite;
	var no:FlxSprite;

	var canpress:Bool;

	var images:Array<String> = ["sus.png", "sus.png", "trans.png", "aroace.png", "brackeys.png"];

	override public function create()
	{
		canpress = true;

		var bg = new FlxSprite(0,0);
		bg.loadGraphic("assets/images/paper.jpg");
		add(bg);
		
		instruction = "Is it sus?";

		pic = new FlxSprite(0,0);
		FlxG.random.shuffle(images);
		pic.loadGraphic("assets/images/microgames/sus/" + images[0]);
		pic.screenCenter();
		add(pic);

		yes = new FlxSprite(18, 329.4);
		yes.frames = FlxAtlasFrames.fromSparrow('assets/images/yes.png', 'assets/images/yes.xml');
		yes.animation.addByPrefix('yes', 'yes', 24, true);
		yes.animation.play('yes');
		add(yes);

		no = new FlxSprite(508.1, 329.4);
		no.frames = FlxAtlasFrames.fromSparrow('assets/images/yes.png', 'assets/images/yes.xml');
		no.animation.addByPrefix('no', 'no', 24, true);
		no.animation.play('no');
		add(no);

		super.create();
		
	}

	override public function update(elapsed)
	{
		super.update(elapsed);
		if (!won) {
			if(FlxG.overlap(cursor, yes) && canpress) {
				if (cursor.mouseispressed) {
					cursor.animation.play('click');
					if(images[0] == "sus.png") {
						won = true;
						pic.color = FlxColor.GREEN;
						canpress = false;
					} else {
						pic.color = FlxColor.RED;
						canpress = false;
					}
				}else {
					if (FlxG.pixelPerfectOverlap(yes, cursor)) {
						cursor.animation.play('over');
					}
				}
			}else if (FlxG.overlap(cursor, no) && canpress) {
				if (cursor.mouseispressed) {
					cursor.animation.play('click');
					if(!(images[0] == "sus.png")) {
						won = true;
						pic.color = FlxColor.GREEN;
						canpress = false;
					} else {
						pic.color = FlxColor.RED;
						canpress = false;
					}
				}else {
					if (FlxG.pixelPerfectOverlap(no, cursor)) {
						cursor.animation.play('over');
					}
				}
			} else {
				cursor.animation.play('normal');
			}
		}

		if (!canpress) {
			cursor.animation.play('normal');
		}
	}

	override public function onTimerFinished()
	{
	    FlxG.switchState(new GameState({won:won, lives:lives}));
	}
}