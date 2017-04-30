package entity.shokuka_states;

import flixel.math.FlxPoint;
import addons.FlxFSM;
import entity.monsters.Shokuka;
import flixel.math.FlxRandom;
import flixel.tweens.FlxTween;

class Idle extends FlxFSMState<Shokuka>
{
    var _cnt:Int = 0;
    override public function enter(owner:Shokuka, fsm:FlxFSM<Shokuka>):Void 
    {
        _cnt = 0;
    }

    override public function update(elapsed:Float, owner:Shokuka, fsm:FlxFSM<Shokuka>):Void 
    {
        if (owner.isOnScreen()) {
            if (_cnt++ >= 60) {
                FlxTween.tween(owner, { alpha: 0}, 0.2,
                    { onComplete: function(tween:FlxTween) {
                        var rnd:FlxRandom = new FlxRandom();
                        var pnt:FlxPoint = owner.checkpoints[rnd.int(0, owner.checkpoints.length-1)].getPosition();
                        while (owner.getPosition().equals(pnt)) {
                            pnt = owner.checkpoints[rnd.int(0, owner.checkpoints.length-1)].getPosition();
                        }
                        owner.setPosition(pnt.x, pnt.y);
                        _cnt = 0;
                        FlxTween.tween(owner, {alpha: 1}, 0.2);
                    }
                });
            }
        } else {
            _cnt = 0;
        }
    }
}