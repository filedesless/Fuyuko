 package entity.ekunaa_states;

import flixel.FlxObject;
import addons.FlxFSM;
import entity.monsters.Ekunaa;

class Wander extends FlxFSMState<Ekunaa>
{
    var _cnt:Int = 0;
    override public function enter(owner:Ekunaa, fsm:FlxFSM<Ekunaa>):Void 
    {
        owner.animation.play("walk");
        _cnt = 0;
    }

    override public function update(elapsed:Float, owner:Ekunaa, fsm:FlxFSM<Ekunaa>):Void 
    {
        if (owner.isTouching(owner.direction))
            owner.direction = if (owner.direction == FlxObject.RIGHT) FlxObject.LEFT else FlxObject.RIGHT;

        owner.velocity.x = (Math.sin(_cnt++ / 100) + 1.5) * if (owner.direction == FlxObject.RIGHT) 75 else -75;
    }
}