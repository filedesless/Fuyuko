package scene.levels;

import scene.ParentState;
import flixel.FlxG;

class Lvl2 extends ParentState {
    override public function create() {
        loadMap(AssetPaths.Lvl1__csv);
        _lvlConfig = openfl.Assets.getText(AssetPaths.Lvl2__json);
        _lvl = 2;

        #if flash
        felix.FelixSound.playBackground(AssetPaths.lvl1__mp3);
        #else
        felix.FelixSound.playBackground(AssetPaths.cave_theme__ogg);
        #end
        super.create();
    }
}