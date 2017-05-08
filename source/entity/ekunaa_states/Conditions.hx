package entity.ekunaa_states;

import flixel.FlxObject;
import flixel.FlxG;
import entity.monsters.Ekunaa;

class Conditions
{
    public static function isTouchingLight(owner:Ekunaa):Bool {
        return owner.isTouchingLight;
    }

    public static function isNotTouchingLight(owner:Ekunaa):Bool {
        return !owner.isTouchingLight;
    }

    public static function playerInSight(owner:Ekunaa):Bool {
        return owner.playerInSight;
    }

    public static function playerNotInSight(owner:Ekunaa):Bool {
        return !owner.playerInSight;
    }

    public static function hitWall(owner:Ekunaa):Bool {
        if (owner.isTouching(FlxObject.WALL)) {
            FlxG.camera.shake(0.05, 0.5);
            return true;
        } else return false;
    }
}