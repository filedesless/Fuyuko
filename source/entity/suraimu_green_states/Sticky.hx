package entity.suraimu_green_states;

import entity.monsters.SuraimuGreen;
import addons.FlxFSM;

class Sticky extends FlxFSMState<SuraimuGreen>
{
    override public function enter(owner:SuraimuGreen, fsm:FlxFSM<SuraimuGreen>):Void 
    {
        owner.animation.play("bubbles");
        owner.velocity.set();
        owner.acceleration.set();
    }
    
    override public function update(elapsed:Float, owner:SuraimuGreen, fsm:FlxFSM<SuraimuGreen>):Void 
    {
        owner.setPosition(owner.target.x - owner.width / 2, owner.target.y - owner.height / 2);
        owner.stickPlayer();
    }

    override public function exit(owner:SuraimuGreen):Void 
    {
        owner.setPosition(owner.target.x - owner.width / 2, owner.target.y - owner.height / 2);
        owner.unStickPlayer();
    }
}