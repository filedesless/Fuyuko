package entity.obstacles.platform_states;

import addons.FlxFSM;

class Idle extends FlxFSMState<Platform>
{
    override public function enter(owner:Platform, fsm:FlxFSM<Platform>):Void 
    {
        owner.reviveTimer = 0;
        owner.angle = 0;
    }

    override public function update(elapsed:Float, owner:Platform, fsm:FlxFSM<Platform>):Void 
    {
    }
}