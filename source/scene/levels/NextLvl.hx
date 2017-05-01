package scene.levels;

class NextLvl extends FlxState {
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