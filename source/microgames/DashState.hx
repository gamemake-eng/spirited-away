package microgames;

import helpers.MicrogameState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
class DashState extends MicrogameState {
	var cube:FlxSprite;
	var good:FlxSprite;
	var bad:FlxSprite;
	var cc:Array<String> = ["green", "red"];
	var colors:Array<FlxColor> = [FlxColor.GREEN, FlxColor.RED, FlxColor.ORANGE, FlxColor.PINK, FlxColor.PURPLE];
	override public function create()
	{
		var bg = new FlxSprite(0,0);
		bg.loadGraphic("assets/images/paper.jpg");
		add(bg);
		FlxG.random.shuffle(cc);
		instruction = "Dash into "+ cc[0] + "!";

		cube = new FlxSprite(0,300);
		cube.makeGraphic(32,32,FlxColor.WHITE);
		FlxG.random.shuffle(colors);
		cube.color = colors[FlxG.random.int(0,4)];
		add(cube);

		bad = new FlxSprite(FlxG.random.int(0,620-60),20);
		bad.makeGraphic(60,60,FlxColor.RED);
		add(bad);
		good = new FlxSprite(FlxG.random.int(0,620-60),20);
		good.makeGraphic(60,60,FlxColor.GREEN);
		add(good);

		if (FlxG.overlap(bad,good)) {
			good.x -= 100;
		}

		super.create();
		
	}

	override public function update(elapsed)
	{
		super.update(elapsed);
		if (!won) {
			cube.x = cursor.x;

			if (cursor.mouseispressed) {
				cube.velocity.y = -600;
			}
		}
		
	    
	    if (FlxG.collide(cube, good)) {
	    	if (cc[0] == "green") {
	    		won = true;
	    	}
	    }
	    if (FlxG.collide(cube, bad)) {
	    	if (cc[0] == "red") {
	    		won = true;
	    	}
	    }
	}

	override public function onTimerFinished()
	{
	    FlxG.switchState(new GameState({won:won, lives:lives}));
	}
}