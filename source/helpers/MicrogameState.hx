package helpers;

import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.ui.FlxBar;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;

class MicrogameState extends FlxState {
	//sprites
	public var cursor:CursorPlayer;
	public var timerBar:FlxBar;

	//confetti
	public var confetti:FlxEmitter;

	//gamestate variables
	public var lives:Int;
	public var won:Bool = false;

	//other
	public var gametimer:FlxTimer;
	public var autoStart:Bool = true;


	//text
	public var instructionText:FlxText;
	public var instruction:String;

	var cols:Array<FlxColor> = [FlxColor.CYAN, FlxColor.RED, FlxColor.ORANGE, FlxColor.BLUE, FlxColor.PURPLE];
	var canemitcon:Bool = true;

	public function new(liv:Int)
	{
	    super();
	    this.lives=liv;
	}

	override public function create()
	{

		
		super.create();
		FlxG.camera.flash(FlxColor.WHITE, 0.5);

		

 		confetti = new FlxEmitter(320, 480/2);
 		confetti.lifespan.set(0);

        for (i in 0 ... 10)
        {
        	var p = new FlxParticle();
        	p.makeGraphic(5, 5, cols[FlxG.random.int(0,4)]);
        	confetti.add(p);
        }
 
        add(confetti);

		cursor = new CursorPlayer(50,50);
		add(cursor);

		//instructions
		instructionText = new FlxText(0,0,0,instruction,60);
		instructionText.screenCenter();
		add(instructionText);
		FlxTween.tween(instructionText,{y:0},0.6,{ease:FlxEase.quadInOut});
		FlxTween.tween(instructionText.scale,{y:instructionText.scale.y/2,x:instructionText.scale.x/2},0.6,{ease:FlxEase.quadInOut});

		timerBar = new FlxBar(0,470,FlxBarFillDirection.LEFT_TO_RIGHT,660);
		timerBar.createFilledBar(FlxColor.RED, FlxColor.GREEN);
		add(timerBar);

		gametimer = new FlxTimer();
		if (autoStart) {
			gametimer.start(5, nextgame, 1);
		}
		
	}

	override public function update(elapsed:Float) {
		timerBar.value = gametimer.timeLeft;
		timerBar.setRange(0,5);

		
		if (won && canemitcon) {
			confetti.start(true);
			FlxG.sound.play("assets/sounds/warioware-So_cool_.wav");
			canemitcon = false;
		}
		super.update(elapsed);
	}

	public function onTimerFinished() {}
	public function beforeCursorCreated() {}


	function nextgame(timer:FlxTimer) {
		timerBar.value = 0;
		
		onTimerFinished();
	}
}