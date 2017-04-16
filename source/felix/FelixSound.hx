package felix;

import flixel.FlxG;
import flixel.system.FlxSound;

class FelixSound {
    #if debug
    static public function debug() {
        FlxG.watch.add(background, "volume");
    }
    #end

    /**
        Generic method to play a sound in a specified channel
        
        @param  path    Path to the sound
        @param  sound   Channel in which to play the sound
        @param  volume  Float between 0 and 100 as saved
        @param  looped  Defaults to true, wether or not the sound will start over when finished
        @param  forceRestart    Defaults to false, wether or not the sound will start over a currently running sound
    **/
    static public function playGeneric(path:String, sound:FlxSound, volume:Float, looped:Bool = true, forceRestart:Bool = false):Void {
        if (sound.playing)
            sound.fadeOut(1, 0);

        sound.loadEmbedded(path, looped);
        sound.play(forceRestart);
        sound.volume = volume * 0.01;
        sound.fadeIn(1, 0, sound.volume);
    }

    static var background:FlxSound = new FlxSound();
    static var bgCurentlyPlaying:String = "";
    /**
        Plays the given sound as the background music, taking volume from saved settings

        @param  path    String pointing to the music file.
    **/
    static public function playBackground(path:String):Void {
        
        if (path != bgCurentlyPlaying)  {
            playGeneric(path, background, getBackgroundVolume());
            bgCurentlyPlaying = path;
        }
    }
    /**
        Get the volume from the background music channel

        @return     A value from 0 to 100
    **/
    static public function getBackgroundVolume():Float {
        return felix.FelixSave.get_background_music();
    }
    /**
        Set the background volume of the music channel

        @param  newValue    A value from 0 to 100
    **/
    static public function setBackgroundVolume(newValue:Float):Void {
        felix.FelixSave.set_background_music(newValue);
        background.volume = 0.01 * felix.FelixSave.get_background_music();
    }

    static var ui:FlxSound = new FlxSound();
    /**
        Plays the given sound as the sfx music, taking volume from saved settings

        @param  path    String pointing to the music file.
    **/
    static public function payUi(path:String):Void {
        playGeneric(path, ui, getUiVolume(), false);
    }
    /**
        Get the volume from the sound effects music channel

        @return     A value from 0 to 100
    **/
    static public function getUiVolume():Float {
        return felix.FelixSave.get_ui_sound();
    }
    /**
        Set the sound effects volume of the music channel

        @param  newValue    A value from 0 to 100
    **/
    static public function setUiVolume(newValue:Float):Void {
        felix.FelixSave.set_ui_sound(newValue);
        ui.volume = 0.01 * felix.FelixSave.get_ui_sound();
    }
}