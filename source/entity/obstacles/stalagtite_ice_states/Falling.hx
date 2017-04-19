package entity.obstacles.stalagtite_ice_states;

import addons.FlxFSM;

class Falling extends FlxFSMState<Stalagtite_ice>
{
    override public function enter(owner:Stalagtite_ice, fsm:FlxFSM<Stalagtite_ice>):Void 
    {
        owner.velocity.y = 600;
        owner.damage = 50;
    }

    override public function update(elapsed:Float, owner:Stalagtite_ice, fsm:FlxFSM<Stalagtite_ice>):Void 
    {
    }

    override public function exit(owner:Stalagtite_ice):Void {
        owner.velocity.y = 0;
    }

}