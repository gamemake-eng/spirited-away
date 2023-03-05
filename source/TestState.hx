package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class TestState extends FlxState {
	//sprites
	var cursor:CursorPlayer;

	//gamestate variables
	var lives:Int;
	var won:Bool;

	//other
	var gametimer:FlxTimer;


	//text
	var instructionText:FlxText;

	public function new(liv:Int)
	{
	    super();
	    this.lives=liv;
	}

	override public function create()
	{
		super.create();


		cursor = new CursorPlayer(50,50);
		add(cursor);

		//instructions
		instructionText = new FlxText(0,0,0,"Click!",60);
		instructionText.screenCenter();
		add(instructionText);
		FlxTween.tween(instructionText,{y:0},0.6,{ease:FlxEase.quadInOut});
		FlxTween.tween(instructionText.scale,{y:instructionText.scale.y/2,x:instructionText.scale.x/2},0.6,{ease:FlxEase.quadInOut});

		gametimer = new FlxTimer();
		gametimer.start(5, nextgame, 1);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (flixel.FlxG.mouse.pressed) {
			won = true;
		}
		filter.update(brightness_threshold, blur_passes);
	}

	function nextgame(timer:FlxTimer) {
		
		FlxG.switchState(new GameState({won:won, lives:lives}));
	}
}