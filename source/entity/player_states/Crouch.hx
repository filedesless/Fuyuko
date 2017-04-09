package entity.player_states;

import addons.FlxFSM;

class Crouch extends FlxFSMState<Player>
{
    override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
    {
        owner.animation.play("crouch");
        owner.speedFactor = 0.4;
    }
}