package entity.obstacles.platform_states;

import flixel.FlxObject;

class Conditions
{
    public static function isTriggered(owner:Platform):Bool {
        return owner.isTouching(FlxObject.UP);
    }
    public static function isReady(owner:Platform):Bool {
        return owner.ready;
    }
    public static function isInvisible(owner:Platform):Bool {
        return !owner.visible;
    }
    public static function isVisible(owner:Platform):Bool {
        return owner.visible;
    }
}