package entity.suraimu_green_states;

import entity.monsters.SuraimuGreen;
import addons.FlxFSM;

class Fall extends FlxFSMState<SuraimuGreen>
{
    override public function enter(owner:SuraimuGreen, fsm:FlxFSM<SuraimuGreen>):Void 
    {
        owner.animation.play("bubble");
        owner.acceleration.y = 600;
    }
    
    override public function update(elapsed:Float, owner:SuraimuGreen, fsm:FlxFSM<SuraimuGreen>):Void 
    {
    }
}