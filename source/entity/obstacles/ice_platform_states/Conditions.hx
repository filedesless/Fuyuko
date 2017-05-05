package entity.obstacles.ice_platform_states;

import flixel.FlxObject;

class Conditions
{
    public static function isTriggered(owner:IcePlatform):Bool {
        return owner.isTouching(FlxObject.UP);
    }
    public static function isReady(owner:IcePlatform):Bool {
        return owner.ready;
    }
    public static function isInvisible(owner:IcePlatform):Bool {
        return !owner.visible;
    }
    public static function isVisible(owner:IcePlatform):Bool {
        return owner.visible;
    }
}