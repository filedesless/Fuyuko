package entity.suraimu_states;

import entity.monsters.Suraimu;

class Conditions
{
    public static function seePlayer(owner:Suraimu):Bool {
        return owner.seesPlayer;
    }
    public static function seePlayerWithItsEyes(owner:Suraimu):Bool { // Not its hands
        // even tho it doesn't have neither one nor the other
        return owner.seesPlayer && !touchesPlayer(owner);
    }
    public static function notSeePlayer(owner:Suraimu):Bool {
        return !owner.seesPlayer;
    }
    public static function nearPlayer(owner:Suraimu):Bool {
        return owner.nearPlayer;
    }
    public static function notNearPlayer(owner:Suraimu):Bool {
        return !owner.nearPlayer;
    }
    public static function touchesPlayer(owner:Suraimu):Bool {
        return owner.touchPlayer;
    }
    public static function falling(owner:Suraimu):Bool {
        return owner.falling;
    }
    public static function grounded(owner:Suraimu):Bool {
        return owner.grounded;
    }
    public static function finished(owner:Suraimu):Bool {
        return owner.animation.finished;
    }

}