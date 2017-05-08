package entity.suraimu_states;

import entity.monsters.Suraimu;
import addons.FlxFSM;

class Idle extends FlxFSMState<Suraimu>
{
    override public function enter(owner:Suraimu, fsm:FlxFSM<Suraimu>):Void 
    {
        owner.animation.play("idle");
        owner.velocity.x = 0;
    }
    
    override public function update(elapsed:Float, owner:Suraimu, fsm:FlxFSM<Suraimu>):Void 
    {
    }
}