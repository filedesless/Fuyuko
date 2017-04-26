 package entity.ekunaa_states;

import flixel.FlxObject;
import addons.FlxFSM;
import entity.monsters.Ekunaa;

class Charge extends FlxFSMState<Ekunaa>
{
    var _cnt:Int = 0;
    override public function enter(owner:Ekunaa, fsm:FlxFSM<Ekunaa>):Void 
    {
        _cnt = 0;
        owner.animation.play("idle");
        owner.velocity.x = 0;
    }

    override public function update(elapsed:Float, owner:Ekunaa, fsm:FlxFSM<Ekunaa>):Void 
    {
        if (owner.isTouching(FlxObject.WALL))
            owner.direction = if (owner.direction == FlxObject.RIGHT) FlxObject.LEFT else FlxObject.RIGHT;

        if (_cnt++ == 120)
            owner.animation.play("charge");

        if (_cnt > 120)
            owner.velocity.x = if (owner.facing == FlxObject.RIGHT) 400 else -400;
    }
}