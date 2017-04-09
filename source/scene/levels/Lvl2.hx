package scene.levels;

import scene.ParentState;
import flixel.FlxG;

class Lvl2 extends ParentState {
    override public function create() {
        player_start.set(128, 12*64);
        loadMap(AssetPaths.Lvl2__csv);

        #if flash
        felix.FelixSound.playBackground(AssetPaths.lvl1__mp3);
        #else
        felix.FelixSound.playBackground(AssetPaths.lvl1__ogg);
        #end

        super.create();
    }
}