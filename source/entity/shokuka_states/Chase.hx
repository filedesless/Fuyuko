package entity.shokuka_states;

import flixel.util.FlxPath;
import entity.misc.CorruptedLightBall;
import entity.misc.LightBall;
import flixel.math.FlxPoint;
import addons.FlxFSM;
import entity.monsters.Shokuka;

class Chase extends FlxFSMState<Shokuka>
{
    function chaseSomeLight(owner:Shokuka):Void {
        owner.path = new FlxPath();
        var points:Array<FlxPoint> = new Array<FlxPoint>();
        for (entity in owner.entities) {
            if (entity.alive)
                if (Std.is(entity, CorruptedLightBall)) {
                    points.push(entity.getMidpoint());
                    break;
                } else if (Std.is(entity, LightBall)) {
                    var light:LightBall = cast(entity, LightBall);
                    if (light.doneFirstPath) {
                        points.push(light.getMidpoint());
                        break;
                    }
                }
        }
        
        if (points.length > 0)
            owner.path.start(points, 400 * felix.FelixSave.get_vitMob(), FlxPath.FORWARD);
    }

    override public function enter(owner:Shokuka, fsm:FlxFSM<Shokuka>):Void 
    {
        chaseSomeLight(owner);
    }

    override public function update(elapsed:Float, owner:Shokuka, fsm:FlxFSM<Shokuka>):Void 
    {
        if (!owner.path.active)
            chaseSomeLight(owner);
    }
}