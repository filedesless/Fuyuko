package entity.shokuka_states;

import flixel.util.FlxPath;
import flixel.math.FlxPoint;
import addons.FlxFSM;
import entity.monsters.Shokuka;

class Report extends FlxFSMState<Shokuka>
{
    override public function enter(owner:Shokuka, fsm:FlxFSM<Shokuka>):Void 
    {
        var dest:FlxPoint = 
            if (owner.checkpoints.length > 0)
                owner.checkpoints[0].getMidpoint();
            else
                new FlxPoint(0,0);

        for (checkpoint in owner.checkpoints) {
            if (owner.y == checkpoint.y || owner.y == dest.y) { // I learn from my mistakes haha
                if (owner.y - checkpoint.y < owner.y - dest.y)
                    dest = checkpoint.getMidpoint();
            } else {
                var distFromDest:Float = (owner.x - dest.x) / (owner.y - dest.y);
                var distFromCheckpoint:Float = (owner.x - checkpoint.x) / (owner.y - checkpoint.y);
                if (distFromCheckpoint < distFromDest)
                    dest = checkpoint.getMidpoint();
            }
        }
        var path = new FlxPath();
        var points:Array<FlxPoint> = [dest];
        owner.path = path;
        path.start(points, 400 * felix.FelixSave.get_vitMob(), FlxPath.FORWARD);
    }
}