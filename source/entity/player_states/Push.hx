package entity.player_states;

import addons.FlxFSM;

class Push extends FlxFSMState<Player>
{
    override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
    {
        
        owner.animation.play("push");
        owner.speedFactor = 0.9;
    }
    
    override public function update(elapsed:Float, owner:Player, fsm:FlxFSM<Player>):Void 
    {
        Player_Sounds.playWalkSound();
        // TODO: delta strength
    }
}