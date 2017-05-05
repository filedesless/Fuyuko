package entity.obstacles.stalagtite_states;

import addons.FlxFSM;

class Falling extends FlxFSMState<Stalagtite>
{
    override public function enter(owner:Stalagtite, fsm:FlxFSM<Stalagtite>):Void 
    {
        owner.velocity.y = 600;
        owner.damage = 50;
    }

    override public function update(elapsed:Float, owner:Stalagtite, fsm:FlxFSM<Stalagtite>):Void 
    {
    }

    override public function exit(owner:Stalagtite):Void {
        owner.velocity.y = 0;
    }

}