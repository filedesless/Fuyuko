package scene.levels;

import scene.ParentState;
import flixel.FlxG;
import flixel.FlxSprite;
import entity.*;

class Lvl1 extends ParentState {
    override public function create() {
        loadMap(AssetPaths.Lvl1__csv);
        _lvlConfig = openfl.Assets.getText(AssetPaths.Lvl1__json);
        _lvl = 1;

        #if flash
        felix.FelixSound.playBackground(AssetPaths.lvl1__mp3);
        #else
        felix.FelixSound.playBackground(AssetPaths.cave_theme__ogg);
        #end
        super.create();
    }
}