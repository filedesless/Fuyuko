package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
    public function new()
    {
        super();

        addChild(new FlxGame(0, 0, scene.MenuState, 1, 60, 60, true));

        #if debug
        FlxG.debugger.visible = true;
        FlxG.debugger.drawDebug = true;
        felix.FelixSound.debug();
        #end
        //trace(felix.FelixSave.get_level_completed());
    }
}
