package entity.suraimu_green_states;

import entity.monsters.SuraimuGreen;
import addons.FlxFSM;

class Idle extends FlxFSMState<SuraimuGreen>
{
    override public function enter(owner:SuraimuGreen, fsm:FlxFSM<SuraimuGreen>):Void 
    {
        owner.animation.play("idle");
        owner.velocity.x = 0;
    }
    
    override public function update(elapsed:Float, owner:SuraimuGreen, fsm:FlxFSM<SuraimuGreen>):Void 
    {
    }
}