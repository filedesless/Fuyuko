package entity.stalagtite_ice_states;

import flixel.FlxObject;
import flixel.FlxG;

class Conditions
{
    public static function isTriggered(owner:Stalagtite_ice):Bool {
        return owner.triggered;
    }
    public static function isReady(owner:Stalagtite_ice):Bool {
        return owner.ready;
    }
    public static function hasHit(owner:Stalagtite_ice):Bool {
        return owner.justTouched(FlxObject.ANY);
    }
}