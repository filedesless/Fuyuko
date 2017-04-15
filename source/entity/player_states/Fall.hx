package entity.player_states;

import addons.FlxFSM;

class Fall extends FlxFSMState<Player>
{
    override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
    {
        owner.animation.play("fall");
    }
    
    override public function update(elapsed:Float, owner:Player, fsm:FlxFSM<Player>):Void 
    {
        if (owner.speedFactor >= 2)
            owner.speedFactor -= 0.2;
        if (owner.speedFactor > 1.5)
            owner.speedFactor -= 0.1;
        if (owner.speedFactor > 0.75)
            owner.speedFactor -= 0.01;
    }
}