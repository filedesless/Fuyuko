package entity.suraimu_states;

import entity.monsters.Suraimu;
import addons.FlxFSM;

class Sticky extends FlxFSMState<Suraimu>
{
    override public function enter(owner:Suraimu, fsm:FlxFSM<Suraimu>):Void 
    {
        owner.animation.play("bubbles");
        owner.velocity.set();
        owner.acceleration.set();
    }
    
    override public function update(elapsed:Float, owner:Suraimu, fsm:FlxFSM<Suraimu>):Void 
    {
        owner.setPosition(owner.target.x - owner.width / 2, owner.target.y - owner.height / 2);
        owner.stickPlayer();
    }

    override public function exit(owner:Suraimu):Void 
    {
        owner.setPosition(owner.target.x - owner.width / 2, owner.target.y - owner.height / 2);
        owner.unStickPlayer();
    }
}