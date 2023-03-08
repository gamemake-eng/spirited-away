package;

import flixel.FlxState;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class GameState extends FlxState {
	var canSetPoints:Bool;
	var points:Int;
	var lives:Int;
	var hasWon:Bool;
	var canPlayAnimation:Bool = true;
	var gametimer:FlxTimer;
	var player:FlxSprite;

	var liveText:FlxSprite;
	var pointsText:FlxText;

	var doors:FlxSprite;

	var microgamelist:Array<FlxState>;

	
	public function new(data:Dynamic)
	{
	    super();
	    if (data=="null") {
	    	this.hasWon=false;
	    	this.lives=4;
	    	this.points=0;
	    	GlobalVars.points = 0;
	    	canSetPoints=false;
	    } else {
	    	this.hasWon=data.won;
	    	this.lives=data.lives;
	    	
	    	canSetPoints=true;
	    }
	}

	override public function create()
	{
	    super.create();

	    FlxG.camera.flash(FlxColor.WHITE, 0.5);

	    if (FlxG.sound.music == null)
	    {
	      FlxG.sound.playMusic("assets/music/deadly_contracts-loop1.ogg", 0.5, true);
	    }

	    FlxG.mouse.visible = false;

		if (!hasWon && canSetPoints) {
			lives-=1;
		} if (canSetPoints) {
			GlobalVars.points += 1;
		}

		


	    doors = new FlxSprite(0,0);
	    doors.frames = FlxAtlasFrames.fromSparrow('assets/images/door.png', 'assets/images/door.xml');
	    doors.animation.addByPrefix('doorclose', 'doorclose', 24, false);
		doors.animation.addByPrefix('dooropen', 'dooropen', 24, false);
		doors.animation.addByPrefix('doorshut', 'doorshut', 24, true);
		
		if (lives == 0 || GlobalVars.points > 8) {
			doors.animation.play("dooropen");
		} else {
			doors.animation.play("doorclose");
		}
		if((doors.animation.finished || canSetPoints) && lives > 0) {
			doors.animation.play("doorshut");
		}

		add(doors);

	    

		player = new FlxSprite(0,0);
		player.frames = FlxAtlasFrames.fromSparrow('assets/images/spirit.png', 'assets/images/spirit.xml');
		player.animation.addByPrefix('win', 'win', 24, true);
		player.animation.addByPrefix('lose', 'lose', 24, true);
		if (hasWon || !canSetPoints) {
			player.animation.play("win");
		} else {
			player.animation.play("lose");
		}

		player.screenCenter();

		add(player);

		FlxTween.tween(player,{y:-190},3,{ease:FlxEase.quadInOut, onComplete:nextgame});

	    liveText = new FlxSprite(0,0);
	    liveText.frames = FlxAtlasFrames.fromSparrow('assets/images/lives.png', 'assets/images/lives.xml');
	    liveText.animation.addByPrefix('0', 'lives0', 24, false);
		liveText.animation.addByPrefix('1', 'lives1', 24, false);
		liveText.animation.addByPrefix('2', 'lives2', 24, false);
		liveText.animation.addByPrefix('3', 'lives3', 24, false);
		liveText.animation.addByPrefix('4', 'lives4', 24, true);

		liveText.animation.play(Std.string(lives));

	    liveText.screenCenter();
	    if (lives>0) {
	    	liveText.x -= 106.45;
	    }
	    liveText.y += 50;
	    add(liveText);

	    pointsText = new FlxText(0,0,0,Std.string(GlobalVars.points),50);
	    pointsText.screenCenter();
	    pointsText.y -= 50;
	    add(pointsText);

		microgamelist = [new microgames.CookieState(lives), new microgames.TurnSquareState(lives), new microgames.DashState(lives), new microgames.SlideState(lives), new microgames.SusState(lives), new microgames.ShootState(lives), new microgames.FoodState(lives), new microgames.FallState(lives), new microgames.MathState(lives)];
		
		var soundtimer = new FlxTimer();

		soundtimer.start(0.5, function(t:FlxTimer) {
			#if neko
			if (hasWon) {
				FlxG.sound.play("assets/sounds/win.wav");
			}
			#else
			if (hasWon) {
				FlxG.sound.play("assets/sounds/win.mp3");
			}
			#end
		}, 1);
		
	}

	override public function update(elapsed)
	{
		super.update(elapsed);
		
	}

	function nextgame(tween:FlxTween):Void {
		if (lives == 0) {
			GlobalVars.win = false;
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
			{
    			FlxG.switchState(new EndState());
			});
		} else if(GlobalVars.points > 8) {
			GlobalVars.win = true;
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
			{
    			FlxG.switchState(new EndState());
			});
			
		} else {
			FlxG.switchState(microgamelist[GlobalVars.points]);
		}
		
	}
}