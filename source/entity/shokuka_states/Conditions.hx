package entity.shokuka_states;

import flixel.FlxObject;
import flixel.FlxG;
import entity.monsters.Shokuka;

class Conditions
{
    public static function seesLight(owner:Shokuka):Bool {
        return owner.numberOfLights > 0;
    }
    public static function doneChasing(owner:Shokuka):Bool {
        return (owner.numberOfLights == 0) || (owner.health >= 50);
    }
    public static function reported(owner:Shokuka):Bool {
        return owner.path.finished;
    }
}