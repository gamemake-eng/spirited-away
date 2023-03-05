package microgames;

import helpers.MicrogameState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;

class SlideState extends MicrogameState {

	var cube1:FlxSprite;
	var cube2:FlxSprite;

	var colors:Array<FlxColor> = [FlxColor.GREEN, FlxColor.RED, FlxColor.ORANGE, FlxColor.PINK, FlxColor.PURPLE];

	override public function create()
	{
		var bg = new FlxSprite(0,0);
		bg.loadGraphic("assets/images/paper.jpg");
		add(bg);
		
		instruction = "Connect!";

		cube1 = new FlxSprite(0,50);
		cube1.loadGraphic("assets/images/microgames/slide/cube.png");
		FlxG.random.shuffle(colors);
		cube1.color = colors[FlxG.random.int(0,4)];
		cube1.velocity.x = FlxG.random.int(100,300);
		add(cube1);

		cube2 = new FlxSprite(400,FlxG.random.int(10,300));
		cube2.loadGraphic("assets/images/microgames/slide/cube.png");
		cube2.immovable = true;
		FlxG.random.shuffle(colors);
		cube2.color = colors[FlxG.random.int(0,4)];
		add(cube2);

		super.create();
		
	}

	override public function update(elapsed)
	{
		super.update(elapsed);
		if (!won) {
			cube1.y = cursor.y;
		}
		
	    
	    if (FlxG.collide(cube1, cube2)) {
	    	won = true;
	    	cube1.velocity.x = 0;
	    }
	}

	override public function onTimerFinished()
	{
	    FlxG.switchState(new GameState({won:won, lives:lives}));
	}
}