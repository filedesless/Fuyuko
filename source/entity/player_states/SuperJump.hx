package entity.player_states;

import addons.FlxFSM;
import flixel.FlxObject;
import flixel.FlxG;

class SuperJump extends FlxFSMState<Player>
{
    var count:Int;
    var jumped:Bool;

    override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
    {
        owner.animation.play("jump");
        count = 0;
        jumped = false;
        owner.speedFactor = 0;
    }
    
    override public function update(elapsed:Float, owner:Player, fsm:FlxFSM<Player>):Void 
    {
        if (!jumped && count++ > 7) {
            owner.velocity.y = -400;
            jumped = true;
            owner.speedFactor = 1;
        }
    }
}