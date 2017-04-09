package scene.levels;

import entity.Platform;
import scene.ParentState;
import flixel.FlxG;
import flixel.FlxSprite;
import entity.Stalagtite_ice;
import entity.Stalagmite;
import entity.IceCube;
import entity.LightCube;

class LvlDemo extends ParentState {
    override public function create() {
        player_start.set(4*64, 15*64);
        loadMap(AssetPaths.LvlDemo__csv);

        #if flash
        felix.FelixSound.playBackground(AssetPaths.lvl1__mp3);
        #else
        felix.FelixSound.playBackground(AssetPaths.lvl1__ogg);
        #end
        super.create();
    }

    override public function loadEvents() {
        _stalagmites.add(new Stalagmite(7*64, 18*64));
        _stalagmites.add(new Stalagmite(8*64, 18*64));

        _stalagtites_ice.add(new Stalagtite_ice(10*64, 2*64, _player));
        _stalagtites_ice.add(new Stalagtite_ice(10*64, 11*64, _player));
        _stalagtites_ice.add(new Stalagtite_ice(15*64, 10*64, _player));

        _lightCubes.add(new LightCube(12*64, 15*64));

        _iceCubes.add(new IceCube(14*64, 7*64));

        _platforms.add(new Platform(5*64, 5*64, _player));
        _platforms.add(new Platform(8*64, 6*64, _player));
        _platforms.add(new Platform(11*64, 7*64, _player));

        super.loadEvents();
    }
}