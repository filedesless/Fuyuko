package entity.obstacles.stalagtite_ice_states;

import flixel.FlxObject;
import flixel.FlxG;
import addons.FlxFSM;

class Triggered extends FlxFSMState<Stalagtite_ice>
{
    var i:Int = 0;
    override public function enter(owner:Stalagtite_ice, fsm:FlxFSM<Stalagtite_ice>):Void 
    {
        owner.velocity.x = 600;
        owner.damage = 10;
    }

    override public function update(elapsed:Float, owner:Stalagtite_ice, fsm:FlxFSM<Stalagtite_ice>):Void 
    {
        if (i++ % 2 == 0) {
            owner.velocity.x *= -1;
        }

        if (i >= 60) {
            owner.ready = true;
        }
    }

    override public function exit(owner:Stalagtite_ice):Void {
        owner.velocity.x = 0;
    }
}