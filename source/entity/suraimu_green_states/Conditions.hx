package entity.suraimu_green_states;

import flixel.FlxObject;
import flixel.FlxG;
import entity.monsters.SuraimuGreen;

class Conditions
{
    public static function seePlayer(owner:SuraimuGreen):Bool {
        return owner.seesPlayer;
    }
    public static function notSeePlayer(owner:SuraimuGreen):Bool {
        return !owner.seesPlayer;
    }
    public static function nearPlayer(owner:SuraimuGreen):Bool {
        return owner.nearPlayer;
    }
    public static function notNearPlayer(owner:SuraimuGreen):Bool {
        return !owner.nearPlayer;
    }
    public static function falling(owner:SuraimuGreen):Bool {
        return owner.falling;
    }
    public static function grounded(owner:SuraimuGreen):Bool {
        return owner.grounded;
    }
    public static function finished(owner:SuraimuGreen):Bool {
        return owner.animation.finished;
    }
    public static function touchesPlayer(owner:SuraimuGreen):Bool {
        return owner.touchPlayer;
    }
    public static function freed(owner:SuraimuGreen):Bool {
        return owner.freed;
    }

}