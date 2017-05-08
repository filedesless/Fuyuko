package scene.levels;

import scene.ParentState;
import flixel.FlxG;

class Lvl4 extends ParentState {
    override public function create() {
        loadMap(AssetPaths.Lvl4__csv);
        _lvlConfig = openfl.Assets.getText(AssetPaths.Lvl4__json);
        _lvl = 4;

        super.create();
    }
}