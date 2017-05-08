package entity.suraimu_states;

import entity.monsters.Suraimu;
import addons.FlxFSM;

class Reco extends FlxFSMState<Suraimu>
{
    override public function enter(owner:Suraimu, fsm:FlxFSM<Suraimu>):Void 
    {
        owner.animation.play("reco");
        owner.velocity.x = 0;
    }
    
    override public function update(elapsed:Float, owner:Suraimu, fsm:FlxFSM<Suraimu>):Void 
    {
    }
}