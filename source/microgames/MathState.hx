package microgames;

import helpers.MicrogameState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;

class MathState extends MicrogameState {
	var num1:Int;
	var num2:Int;

	var canpress:Bool = true;

	var problem:FlxText;

	var text1:FlxText;
	var text2:FlxText;
	var box1:FlxSprite;
	var box2:FlxSprite;
	override public function create()
	{
		var bg = new FlxSprite(0,0);
		bg.loadGraphic("assets/images/paper.jpg");
		add(bg);

		instruction = "Solve!";

		num1 = FlxG.random.int(0,10);
		num2 = FlxG.random.int(0,10);

		problem = new FlxText(0,0,0,num1 + " X " + num2,50);
		problem.screenCenter();
		add(problem);

		text1 = new FlxText(0,0,0,Std.string(FlxG.random.int(0,100)),50);
		text1.screenCenter();
		text1.y += 60;
		text1.x -= 70;
		box1 = new FlxSprite(text1.x, text1.y);
		box1.makeGraphic(50,50,FlxColor.TRANSPARENT);
		add(box1);
		add(text1);

		text2 = new FlxText(0,0,0,Std.string(num1*num2),50);
		text2.screenCenter();
		text2.y += 60;
		text2.x += 70;
		box2 = new FlxSprite(text2.x, text2.y);
		box2.makeGraphic(50,50,FlxColor.TRANSPARENT);
		add(box2);
		add(text2);


		super.create();
		
	}

	override public function update(elapsed)
	{
		super.update(elapsed);
		if (!won) {
			if(FlxG.overlap(cursor, box2) && canpress) {
				if (cursor.mouseispressed) {
					cursor.animation.play('click');
					won = true;
					problem.color = FlxColor.GREEN;
					canpress = false;
				}else {
					if (FlxG.pixelPerfectOverlap(box2, cursor)) {
						cursor.animation.play('over');
					}
				}
			}

			if(FlxG.overlap(cursor, box1) && canpress) {
				if (cursor.mouseispressed) {
					cursor.animation.play('click');
					won = false;
					problem.color = FlxColor.RED;
					canpress = false;
				}else {
					if (FlxG.pixelPerfectOverlap(box1, cursor)) {
						cursor.animation.play('over');
					}
				}
			}
		}else {
			
		}
		
	}

	override public function onTimerFinished()
	{
	    FlxG.switchState(new GameState({won:won, lives:lives}));
	}
}