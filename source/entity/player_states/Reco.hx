package entity.player_states;

import addons.FlxFSM;

class Reco extends FlxFSMState<Player>
{
    override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
    {
        owner.animation.play("reco");
        owner.speedFactor = 0.1;
    }
}