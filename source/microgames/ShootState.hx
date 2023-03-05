package microgames;

import helpers.MicrogameState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;

class ShootState extends MicrogameState {
	var sus:FlxSprite;

	override public function create()
	{
		var bg = new FlxSprite(0,0);
		bg.loadGraphic("assets/images/paper.jpg");
		add(bg);

		instruction = "Shoot the crewmate!";

		sus = new FlxSprite(0,0);
		sus.loadGraphic("assets/images/microgames/sus/sus.png");
		sus.screenCenter();
		sus.x = 0;
		sus.y = FlxG.random.int(0,400);
		sus.velocity.x = FlxG.random.int(10,300);
		add(sus);


		super.create();
		
	}

	override public function update(elapsed)
	{
		super.update(elapsed);
		if (!won) {
			if (FlxG.overlap(cursor, sus)) {
		    	if (cursor.mouseispressed) {
		    		cursor.animation.play("click");
		    		won = true;
		    	}else {
		    		cursor.animation.play("over");
		    	}
	    	}else {
	    		cursor.animation.play("normal");
	    	}
		}else {
			cursor.animation.play("normal");
			sus.velocity.x = 0;
			sus.velocity.y += 10;
		}
		
	    

	    
	}

	override public function onTimerFinished()
	{
	    FlxG.switchState(new GameState({won:won, lives:lives}));
	}
}