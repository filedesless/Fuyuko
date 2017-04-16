package entity.player_states;

import flixel.system.FlxSound;
import flixel.math.FlxRandom;

class Player_Sounds {
    static var path:String = "assets/sounds/walk/";
    static var _walkSound:FlxSound = new FlxSound();
    static var sounds:Array<String> = [
        "Corsica_S-Walking_on_snow_covered_gravel_01.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_02.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_03.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_04.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_05.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_06.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_07.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_08.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_09.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_10.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_11.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_12.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_13.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_14.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_15.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_16.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_17.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_18.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_01.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_02.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_03.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_04.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_05.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_06.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_07.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_08.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_09.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_10.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_11.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_12.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_13.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_14.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_15.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_16.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_17.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_18.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_19.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_20.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_21.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_22.ogg",
        "Corsica_S-Walking_on_snow_covered_gravel_and_ice_23.ogg"
    ];

    public static function playWalkSound():Void {
        if (!_walkSound.playing)
        {
            var rnd:FlxRandom = new FlxRandom();
            var snd = sounds[rnd.int(0, sounds.length-1)];
            felix.FelixSound.playGeneric(path + snd, 
                _walkSound, felix.FelixSave.get_sound_effects(), false);
        }
    }
}