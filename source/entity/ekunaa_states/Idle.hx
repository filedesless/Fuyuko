 package entity.ekunaa_states;

import addons.FlxFSM;
import entity.monsters.Ekunaa;

class Idle extends FlxFSMState<Ekunaa>
{
    override public function enter(owner:Ekunaa, fsm:FlxFSM<Ekunaa>):Void 
    {
        owner.animation.play("idle");
        owner.velocity.x = 0;
    }

    override public function update(elapsed:Float, owner:Ekunaa, fsm:FlxFSM<Ekunaa>):Void 
    {
    }
}