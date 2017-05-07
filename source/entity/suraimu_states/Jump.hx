package entity.suraimu_states;

import flixel.FlxObject;
import entity.monsters.Suraimu;
import addons.FlxFSM;

class Jump extends FlxFSMState<Suraimu>
{
    override public function enter(owner:Suraimu, fsm:FlxFSM<Suraimu>):Void 
    {
        owner.animation.play("jump");
        owner.velocity.y = -350;
        owner.velocity.x = 150 * if (owner.facing == FlxObject.RIGHT) 1 else -1;
    }
    
    override public function update(elapsed:Float, owner:Suraimu, fsm:FlxFSM<Suraimu>):Void 
    {
    }
}