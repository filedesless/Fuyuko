package entity.obstacles.ice_platform_states;

import addons.FlxFSM;

class Idle extends FlxFSMState<IcePlatform>
{
    override public function enter(owner:IcePlatform, fsm:FlxFSM<IcePlatform>):Void 
    {
        owner.reviveTimer = 0;
        owner.angle = 0;
    }

    override public function update(elapsed:Float, owner:IcePlatform, fsm:FlxFSM<IcePlatform>):Void 
    {
    }
}