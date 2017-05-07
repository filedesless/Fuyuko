package entity.suraimu_states;

import entity.monsters.Suraimu;
import addons.FlxFSM;

class Air extends FlxFSMState<Suraimu>
{
    override public function enter(owner:Suraimu, fsm:FlxFSM<Suraimu>):Void 
    {
        owner.animation.play("bubble");
        owner.acceleration.y = 600;
    }
    
    override public function update(elapsed:Float, owner:Suraimu, fsm:FlxFSM<Suraimu>):Void 
    {
    }
}