package scene.levels;

import scene.ParentState;

class Lvl1 extends ParentState {
    override public function create() {
        loadMap(AssetPaths.Lvl1__csv);
        _lvlConfig = openfl.Assets.getText(AssetPaths.Lvl1__json);
        _lvl = 1;

        super.create();
    }
}