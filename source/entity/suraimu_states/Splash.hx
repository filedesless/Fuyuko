package entity.suraimu_states;

import entity.monsters.Suraimu;
import addons.FlxFSM;

class Splash extends FlxFSMState<Suraimu>
{
    override public function enter(owner:Suraimu, fsm:FlxFSM<Suraimu>):Void 
    {
        owner.animation.play("splash");
        owner.velocity.x = 0;
        owner.playSplash();
    }
    
    override public function update(elapsed:Float, owner:Suraimu, fsm:FlxFSM<Suraimu>):Void 
    {
    }
}