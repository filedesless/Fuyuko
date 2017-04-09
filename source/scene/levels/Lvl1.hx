package scene.levels;

import scene.ParentState;
import flixel.FlxG;
import flixel.FlxSprite;
import entity.Stalagmite;
import entity.IceCube;
import entity.LightCube;

class Lvl1 extends ParentState {
    override public function create() {
        player_start.set(3*64, 43*64);
        loadMap(AssetPaths.Lvl1__csv);

        #if flash
        felix.FelixSound.playBackground(AssetPaths.lvl1__mp3);
        #else
        felix.FelixSound.playBackground(AssetPaths.lvl1__ogg);
        #end
        super.create();
    }

    override public function loadEvents() {
        _stalagmites.add(new Stalagmite(8*64, 47*64));
        _lightCubes.add(new LightCube(12*64, 44*64));

        super.loadEvents();
    }
}