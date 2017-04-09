package entity.player_states;

import flixel.FlxObject;
import addons.FlxFSM;
import flixel.FlxG;

class Walk extends FlxFSMState<Player>
{
    override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
    {
        owner.animation.play("walk");
        owner.speedFactor = 1;
    }
    
    override public function update(elapsed:Float, owner:Player, fsm:FlxFSM<Player>):Void 
    {
    }
}