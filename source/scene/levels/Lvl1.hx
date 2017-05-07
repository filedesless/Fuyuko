package scene.levels;

import scene.ParentState;

class Lvl1 extends ParentState {
    override public function create() {
        loadMap(AssetPaths.Lvl2__csv);
        _lvlConfig = openfl.Assets.getText(AssetPaths.Lvl2__json);
        _lvl = 1;

        #if flash
        felix.FelixSound.playBackground(AssetPaths.lvl1__mp3);
        #else
        felix.FelixSound.playBackground(AssetPaths.cave_theme__ogg);
        #end
        super.create();
    }
}