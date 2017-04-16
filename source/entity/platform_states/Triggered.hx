package entity.platform_states;

import addons.FlxFSM;

class Triggered extends FlxFSMState<Platform>
{
    var i:Int = 0;
    override public function enter(owner:Platform, fsm:FlxFSM<Platform>):Void 
    {
        owner.angularVelocity = 0;
        i = 0;
    }

    override public function update(elapsed:Float, owner:Platform, fsm:FlxFSM<Platform>):Void 
    {
        if (++i >= 32) {
            if (owner.angularVelocity == 0)
                owner.angularVelocity = 90;
            if (i % 5 == 0)
                owner.angularVelocity *= -1;
            if (i >= 64)        
                owner.ready = true;
        }
    }

    override public function exit(owner:Platform):Void {
        i = 0;
        owner.ready = false;
        owner.angularVelocity = 0;
    }
}