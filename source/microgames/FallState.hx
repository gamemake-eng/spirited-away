package microgames;

import helpers.MicrogameState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;

class FallState extends MicrogameState {

	var player:FlxSprite;
	var block1:FlxSprite;
	var block2:FlxSprite;

	var blood:FlxEmitter;

	var ce:Bool = true;
	var bwidth:Int;

	override public function create()
	{
		var bg = new FlxSprite(0,0);
		bg.loadGraphic("assets/images/paper.jpg");
		add(bg);

		instruction = "Doge!";

		blood = new FlxEmitter(320, 480/2);
 		blood.lifespan.set(0);

        for (i in 0 ... 50)
        {
        	var p = new FlxParticle();
        	p.makeGraphic(5, 5, FlxColor.RED);
        	blood.add(p);
        }

        bwidth = FlxG.random.int(100,300);
 
        

		player = new FlxSprite(320,0);
		player.loadGraphic("assets/images/microgames/fall/player.png");
		player.velocity.y = FlxG.random.int(100,200);
		add(player);

		block1 = new FlxSprite(0,200);
		block1.makeGraphic(300,10,FlxColor.BLACK);
		add(block1);

		block2 = new FlxSprite(640-300,400);
		block2.makeGraphic(300,10,FlxColor.BLACK);
		add(block2);


		add(blood);

		super.create();
		
	}

	override public function update(elapsed)
	{
		super.update(elapsed);
		if (!won) {
			player.x = cursor.x;
			if (player.y > 480) {
				won = true;
			}

			if (FlxG.overlap(block1,player) || FlxG.overlap(block2,player)) {
				blood.x = player.x;
				blood.y = player.y;
				if (ce) {
					blood.start();
					ce=false;
				}
				player.destroy();
			}
		}else {
			player.velocity.x = 0;
		}
		
	}

	override public function onTimerFinished()
	{
	    FlxG.switchState(new GameState({won:won, lives:lives}));
	}
}