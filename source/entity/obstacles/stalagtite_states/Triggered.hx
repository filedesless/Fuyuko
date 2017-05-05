package entity.obstacles.stalagtite_states;

import addons.FlxFSM;

class Triggered extends FlxFSMState<Stalagtite>
{
    var i:Int = 0;
    override public function enter(owner:Stalagtite, fsm:FlxFSM<Stalagtite>):Void 
    {
        owner.velocity.x = 600;
        owner.damage = 10;
    }

    override public function update(elapsed:Float, owner:Stalagtite, fsm:FlxFSM<Stalagtite>):Void 
    {
        if (i++ % 2 == 0) {
            owner.velocity.x *= -1;
        }

        if (i >= 60) {
            owner.ready = true;
        }
    }

    override public function exit(owner:Stalagtite):Void {
        owner.velocity.x = 0;
    }
}