package scene.levels;

import scene.ParentState;
import flixel.FlxG;

class Lvl3 extends ParentState {
    override public function create() {
        loadMap(AssetPaths.Lvl3__csv);
        _lvlConfig = openfl.Assets.getText(AssetPaths.Lvl3__json);
        _lvl = 3;

        super.create();
    }
}