package entity.player_states;

import flixel.FlxObject;
import flixel.FlxG;
import addons.FlxFSM;

class Idle extends FlxFSMState<Player>
{
    override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
    {
        owner.animation.play("idle");
        owner.speedFactor = 0;
    }

    override public function update(elapsed:Float, owner:Player, fsm:FlxFSM<Player>):Void 
    {
    }
}