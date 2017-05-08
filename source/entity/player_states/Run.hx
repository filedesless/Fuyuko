package entity.player_states;

import addons.FlxFSM;

class Run extends FlxFSMState<Player>
{
    override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
    {
        owner.animation.play("before_run");
        owner.speedFactor = 1.2;
    }
    
    override public function update(elapsed:Float, owner:Player, fsm:FlxFSM<Player>):Void 
    {
        if (owner.animation.finished && owner.animation.curAnim.name != "run")
            owner.animation.play("run");
        Player_Sounds.playWalkSound();
        if (owner.speedFactor < 1.75)
            owner.speedFactor += 0.01;
    }
}