package scene.levels;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxState;

class NextLvl extends FlxState {
    var _lvl:Int = 0;

    public override function new(lvl:Int) {
        super();
        _lvl = lvl;
    }

    override public function create():Void {
        FlxG.camera.fade(FlxColor.TRANSPARENT, 0.5, false, actuallyQuit);
    }

    function actuallyQuit():Void {
        FlxG.camera.fade(FlxColor.TRANSPARENT, 0.5, true);
        var lvl:ParentState = switch (_lvl) {
            case 1: new Lvl2();
            case _: new Lvl1();
        }
        FlxG.switchState(lvl);
    }
}