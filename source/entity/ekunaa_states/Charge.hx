 package entity.ekunaa_states;

import flixel.FlxObject;
import addons.FlxFSM;
import entity.monsters.Ekunaa;
import entity.obstacles.IceCube;

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
        if (owner.isTouching(owner.direction))
        {
            owner.direction = if (owner.direction == FlxObject.RIGHT) FlxObject.LEFT else FlxObject.RIGHT;
            owner.playHitWall();
        }
            

        if (_cnt++ == 120)
            owner.animation.play("charge");
            
            

        for (entity in owner.entities) {
            if (entity.alive && Std.is(entity, IceCube)) {
                var iceCube:IceCube = cast (entity, IceCube);
                FlxObject.updateTouchingFlags(owner, iceCube);
                if (owner.overlaps(iceCube)) {
                    iceCube.shatter();
                }
            }
        }

        if (_cnt > 120)
        {
            owner.velocity.x = felix.FelixSave.get_vitMob() * if (owner.direction == FlxObject.RIGHT) 550 else -550;
            owner.playCharge();
        }
            
    }
}