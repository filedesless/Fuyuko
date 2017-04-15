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
    **/
    static private function playGeneric(path:String, sound:FlxSound, volume:Float, looped:Bool = true):Void {
        if (sound.playing)
            sound.fadeOut(1, 0);

        sound.loadEmbedded(path, looped);
        sound.play();
        sound.volume = volume * 0.01;
        sound.fadeIn(1, 0, sound.volume);
    }

    static var ambient:FlxSound = new FlxSound();
    static public function playAmbient(path:String):Void {
        playGeneric(path, ambient, getAmbientVolume());
    }
    static public function getAmbientVolume():Float {
        return felix.FelixSave.get_ambient_music();
    }
    static public function setAmbientVolume(newValue:Float):Void {
        felix.FelixSave.set_ambient_music(newValue);
        ambient.volume = 0.01 * felix.FelixSave.get_ambient_music();
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

    static var sfx:FlxSound = new FlxSound();
    /**
        Plays the given sound as the sfx music, taking volume from saved settings

        @param  path    String pointing to the music file.
    **/
    static public function playSfx(path:String):Void {
        playGeneric(path, sfx, getSfxVolume(), false);
    }
    /**
        Get the volume from the sound effects music channel

        @return     A value from 0 to 100
    **/
    static public function getSfxVolume():Float {
        return felix.FelixSave.get_sound_effects();
    }
    /**
        Set the sound effects volume of the music channel

        @param  newValue    A value from 0 to 100
    **/
    static public function setSfxVolume(newValue:Float):Void {
        felix.FelixSave.set_sound_effects(newValue);
        sfx.volume = 0.01 * felix.FelixSave.get_sound_effects();
    }
    static public function isSfxPlaying():Bool {
        return sfx.playing;
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