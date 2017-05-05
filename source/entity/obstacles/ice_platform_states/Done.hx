package entity.obstacles.ice_platform_states;

import addons.FlxFSM;

class Done extends FlxFSMState<IcePlatform>
{
    override public function enter(owner:IcePlatform, fsm:FlxFSM<IcePlatform>):Void {
        owner.velocity.y = 0;
    }

    override public function update(elapsed:Float, owner:IcePlatform, fsm:FlxFSM<IcePlatform>):Void {
        
    }

    override public function exit(owner:IcePlatform):Void {
    }

}