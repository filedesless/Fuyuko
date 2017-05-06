package entity.suraimu_green_states;

import flixel.FlxObject;
import entity.monsters.SuraimuGreen;
import addons.FlxFSM;

class Jump extends FlxFSMState<SuraimuGreen>
{
    override public function enter(owner:SuraimuGreen, fsm:FlxFSM<SuraimuGreen>):Void 
    {
        owner.animation.play("jump");
        owner.velocity.y = -350;
        owner.velocity.x = 150 * if (owner.facing == FlxObject.RIGHT) 1 else -1;
    }
    
    override public function update(elapsed:Float, owner:SuraimuGreen, fsm:FlxFSM<SuraimuGreen>):Void 
    {
    }
}