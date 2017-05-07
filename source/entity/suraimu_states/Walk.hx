package entity.suraimu_states;

import flixel.FlxObject;
import entity.monsters.Suraimu;
import addons.FlxFSM;

class Walk extends FlxFSMState<Suraimu>
{
    override public function enter(owner:Suraimu, fsm:FlxFSM<Suraimu>):Void 
    {
        owner.animation.play("walk");
    }
    
    override public function update(elapsed:Float, owner:Suraimu, fsm:FlxFSM<Suraimu>):Void 
    {
        owner.velocity.x = 100 * if (owner.facing == FlxObject.RIGHT) 1 else -1;
    }
}