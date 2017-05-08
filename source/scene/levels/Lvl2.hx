package scene.levels;

import scene.ParentState;
import flixel.FlxG;

class Lvl2 extends ParentState {
    override public function create() {
        loadMap(AssetPaths.Lvl2__csv);
        _lvlConfig = openfl.Assets.getText(AssetPaths.Lvl2__json);
        _lvl = 2;

        super.create();
    }
}