package entity.suraimu_green_states;

import flixel.FlxObject;
import entity.monsters.SuraimuGreen;
import addons.FlxFSM;

class Walk extends FlxFSMState<SuraimuGreen>
{
    override public function enter(owner:SuraimuGreen, fsm:FlxFSM<SuraimuGreen>):Void 
    {
        owner.animation.play("walk");
    }
    
    override public function update(elapsed:Float, owner:SuraimuGreen, fsm:FlxFSM<SuraimuGreen>):Void 
    {
        owner.velocity.x = 100 * if (owner.facing == FlxObject.RIGHT) 1 else -1;
    }
}