package microgames;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import helpers.MicrogameState;
import flixel.graphics.frames.FlxAtlasFrames;


class TurnSquareState extends MicrogameState {

	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var cube:FlxSprite;

	var tex:FlxAtlasFrames;

	var angles:Array<Int> = [0, 90];
	var canrotate:Bool;

	override public function create()
	{
		var bg = new FlxSprite(0,0);
		bg.loadGraphic("assets/images/paper.jpg");
		add(bg);
		
		instruction = "Turn!";

		leftArrow = new FlxSprite(51, 322);
		rightArrow = new FlxSprite(432.8, 332);

		tex = FlxAtlasFrames.fromSparrow('assets/images/microgames/turncube/arrow.png', 'assets/images/microgames/turncube/arrow.xml');

		leftArrow.frames=tex;
		rightArrow.frames=tex;
		leftArrow.animation.addByPrefix('leftarrow', 'leftarrow', 24, true);
		rightArrow.animation.addByPrefix('rightarrow', 'rightarrow', 24, true);

		leftArrow.animation.play("leftarrow");
		rightArrow.animation.play("rightarrow");

		cube = new FlxSprite(182.3,36.6);
		cube.loadGraphic("assets/images/microgames/turncube/brackeys.png");
		
		cube.angle = angles[FlxG.random.int(0,1)];

		add(cube);
		add(leftArrow);
		add(rightArrow);

		super.create();
		
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if(FlxG.overlap(cursor, leftArrow, turnLeft) || FlxG.overlap(cursor, rightArrow, turnRight)) {
			if (cursor.mouseispressed && (FlxG.pixelPerfectOverlap(leftArrow, cursor) || FlxG.pixelPerfectOverlap(rightArrow, cursor))) {
				cursor.animation.play('click');
			}else {
				if (FlxG.pixelPerfectOverlap(leftArrow, cursor) || FlxG.pixelPerfectOverlap(rightArrow, cursor)) {
					cursor.animation.play('over');
				}
			}
		}else {
			cursor.animation.play('normal');
		}

		if (!cursor.mouseispressed) {
			canrotate = true;
		}

		if (cube.angle == -45 || cube.angle == 45) {
			if (won == false) {
				won = true;
			}
			
		}
		
	}

	function turnLeft(spr1:FlxSprite, spr2:FlxSprite) {
		if (FlxG.pixelPerfectOverlap(spr1, spr2) && canrotate && won == false) {
			if (cursor.mouseispressed) {
				cube.angle = cube.angle - 45;
				if(cube.angle < -45) {
					cube.angle = -45;
				}
				canrotate = false;
			}
		}
	}
	function turnRight(spr1:FlxSprite, spr2:FlxSprite) {
		if (FlxG.pixelPerfectOverlap(spr1, spr2) && canrotate && won == false) {
			if (cursor.mouseispressed) {
				cube.angle = cube.angle + 45;
				if(cube.angle > 45) {
					cube.angle = 45;
				}
				canrotate = false;
			}
		}
	}

	override public function onTimerFinished()
	{
	    FlxG.switchState(new GameState({won:won, lives:lives}));
	}
}