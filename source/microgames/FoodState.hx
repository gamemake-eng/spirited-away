package microgames;

import helpers.MicrogameState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;

class FoodState extends MicrogameState {
	var food:FlxSprite;
	var fork:FlxSprite;
	override public function create()
	{
		var bg = new FlxSprite(0,0);
		bg.loadGraphic("assets/images/paper.jpg");
		add(bg);

		instruction = "Stab the carrot!";

		food = new FlxSprite(0,10);
		food.loadGraphic("assets/images/microgames/food/carrot.png");
		food.x = FlxG.random.int(0,640-133);
		

		fork = new FlxSprite(0,331.4);
		fork.loadGraphic("assets/images/microgames/food/fork.png");
		fork.velocity.x = FlxG.random.int(200,300);
		add(fork);
		add(food);

		super.create();
		
	}

	override public function update(elapsed)
	{
		super.update(elapsed);
		if (!won) {
			if (cursor.mouseispressed) {
				fork.velocity.x = 0;
				fork.velocity.y = -500;
			}
			if (FlxG.overlap(fork,food)) {
				fork.y -= 19;
				won = true;
			}
		}else {
			fork.velocity.y = 0;
			cursor.animation.play("normal");
		}
		
	    

	    
	}

	override public function onTimerFinished()
	{
	    FlxG.switchState(new GameState({won:won, lives:lives}));
	}
}