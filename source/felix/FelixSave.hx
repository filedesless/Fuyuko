package felix;

import flixel.FlxG;

/**
    Simple wrapper around objects that should be expected from a save
**/
class FelixSave {
    @:isVar static var level_completed(get, set):Int = 0;

    public static function get_level_completed():Int {
        if (FlxG.save.data.level_completed != null)
            return FlxG.save.data.level_completed;
        return 0;
    }
    /**
        Sets the number of completed levels and saves it
        @param  newValue    A positive value higher than the current completed level_completed
        @return The value saved
    **/
    public static function set_level_completed(newValue:Int):Int {
        if (newValue > level_completed) {
            FlxG.save.data.level_completed = newValue;
            FlxG.save.flush();
            return newValue;
        }
        return level_completed;
    }

    @:isVar static var setup_done(get, set):Bool = false;

    public static function get_setup_done():Bool {
        if (FlxG.save.data.setup_done != null)
            return FlxG.save.data.setup_done;
        return false;
    }
    /**
        Sets the setup flag to true or false
        @param  newValue    A boolean value indicating wether or not the setup was done
        @return The value saved
    **/
    public static function set_setup_done(newValue:Bool):Bool {
        if (newValue != setup_done) {
            FlxG.save.data.setup_done = newValue;
            FlxG.save.flush();
            return newValue;
        }
        return setup_done;
    }

    /** Volume of the ambient music, from 0 to 100 **/
    @:isVar static var ambient_music(get, set):Float = -1;
    /**
        Gets the ambient music volume from save
        @return     A float, should be between 0 and 100
    **/
    public static function get_ambient_music():Float {
        if (ambient_music == -1) { // mem cache miss, fetch from disk
            var val:Null<Float> = FlxG.save.data.ambient_music;
            if (val != null && val <= 100 && val >= 0)
                return ambient_music = val; // calls setter
            else // shit, choke
                return ambient_music = 50;
        } else // cache hit
            return ambient_music;
    }
    /**
        Saves the given ambient music volume to disk
        @param  newValue    A float between 0 and 100
        @return             The actual value of the ambient music's volume
    **/
    public static function set_ambient_music(newValue:Float):Float {
        if (newValue <= 100 && newValue >= 0) {
            FlxG.save.data.ambient_music = newValue;
            FlxG.save.flush();
            ambient_music = newValue;
        }
        return ambient_music; // calls getter
    }

    /** Volume of the background music, from 0 to 100 **/
    @:isVar static var background_music(get, set):Float = -1;
    /**
        Gets the background music volume from save
        @return     A float, should be between 0 and (default) 100
    **/
    public static function get_background_music():Float {
        if (background_music == -1) { // mem cache miss, fetch from disk
            var val:Null<Float> = FlxG.save.data.background_music;
            if (val != null && val <= 100 && val >= 0)
                return background_music = val;
            else // shit, choke
                return background_music = 50;
        } else // cache hit
            return background_music;
    }
    /**
        Saves the given background music volume to disk
        @param  newValue    A float between 0 and 100
        @return             The actual value of the background music's volume
    **/
    public static function set_background_music(newValue:Float):Float {
        if (newValue <= 100 && newValue >= 0) {
            FlxG.save.data.background_music = newValue;
            FlxG.save.flush();
            background_music = newValue;
        }
        return background_music; // calls getter
    }

    /** Volume of the sound effects, from 0 to 100 **/
    @:isVar static var sound_effects(get, set):Float = -1;
    /**
        Gets the sound effects volume from save
        @return     A float, should be between 0 and 100, defaults to 50
    **/
    public static function get_sound_effects():Float {
        if (sound_effects == -1) { // mem cache miss, fetch from disk
            var val:Null<Float> = FlxG.save.data.sound_effects;
            if (val != null && val <= 100 && val >= 0)
                return sound_effects = val;
            else // shit, choke
                return sound_effects = 50;
        } else // cache hit
            return sound_effects;
    }
    /**
        Saves the given sound effects volume to disk
        @param  newValue    A float between 0 and 100
        @return             The actual value of the sound effects's volume
    **/
    public static function set_sound_effects(newValue:Float):Float {
        if (newValue <= 100 && newValue >= 0) {
            FlxG.save.data.sound_effects = newValue;
            FlxG.save.flush();
            sound_effects = newValue;
        }
        return sound_effects; // calls getter
    }

    /** Volume of the UI sound effect, from 0 to 100 **/
    @:isVar static var ui_sound(get, set):Float = -1;
    /**
        Gets the sound effects volume from save
        @return     A float, should be between 0 and (default) 100
    **/
    public static function get_ui_sound():Float {
        if (ui_sound == -1) { // mem cache miss, fetch from disk
            var val:Null<Float> = FlxG.save.data.ui_sound;
            if (val != null && val <= 100 && val >= 0)
                return ui_sound = val;
            else // shit, choke
                return ui_sound = 50;
        } else // cache hit
            return ui_sound;
    }
    /**
        Saves the given sound effects volume to disk
        @param  newValue    A float between 0 and 100
        @return             The actual value of the sound effects's volume
    **/
    public static function set_ui_sound(newValue:Float):Float {
        if (newValue <= 100 && newValue >= 0) {
            FlxG.save.data.ui_sound = newValue;
            FlxG.save.flush();
            ui_sound = newValue;
        }
        return ui_sound; // calls getter
    }

}