package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;

class EndState extends FlxState
{
	var text2:FlxText;
	override public function create()
	{
		super.create();

		if (GlobalVars.win) {
			FlxG.openURL("https://www.youtube.com/watch?v=dQw4w9WgXcQ");
			text2 = new FlxText(0,0,0,"Haha u won",50);
			text2.screenCenter();
			add(text2);
			text2 = new FlxText(0,0,0,"You can play a better game now",20);
			text2.screenCenter();
			text2.y += 60;
			add(text2);
		} else {
			text2 = new FlxText(0,0,0,"Haha u lost",50);
			text2.screenCenter();
			add(text2);
			text2 = new FlxText(0,0,0,"Click to restart",20);
			text2.screenCenter();
			text2.y += 60;
			add(text2);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (!GlobalVars.win) {
			if (FlxG.mouse.pressed) {
				FlxG.switchState(new GameState("null"));
			}
		}
	}
}