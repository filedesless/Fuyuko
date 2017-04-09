package entity.platform_states;

import flixel.FlxObject;
import flixel.FlxG;

class Conditions
{
    public static function isTriggered(owner:Platform):Bool {
        return owner.isTouching(FlxObject.UP);
    }
    public static function isReady(owner:Platform):Bool {
        return owner.ready;
    }
    public static function hasHit(owner:Platform):Bool {
        return owner.isTouching(FlxObject.DOWN);
    }
    public static function isAlive(owner:Platform):Bool {
        return owner.alive;
    }
}