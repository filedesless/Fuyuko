package entity.player_states;

import addons.FlxFSM;

class Shooting extends FlxFSMState<Player>
{
    override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
    {
        owner.animation.play("shoot");
    }
}