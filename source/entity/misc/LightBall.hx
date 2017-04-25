package entity.misc;

import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.util.FlxPath;
import flixel.FlxG;
import entity.Entity;
import entity.Player;
import flixel.tile.FlxTilemap;

class LightBall extends Entity implements ILightSource {
    var _cnt:Int = 0;
    var _lightcnt:Int = 0;
    public var baseLight:Int = 128;
    public var doneFirstPath:Bool = false;

    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap) {
        super(X, Y, player, level);
        loadGraphic(AssetPaths.orb__png, true, 32, 32);

        scale.set(1.5, 1.5);
        updateHitbox();

        health = 5;

        elasticity = 1;
        
        animation.add("idle", [1,2,13,14,13,2], 8, true);
        animation.play("idle");
    }

    public override function update(elapsed:Float):Void {
        velocity.y = Math.sin(_cnt++ * 0.1) * 25;

        immovable = false;
        FlxG.collide(this, _level);
        immovable = true;

        if (!doneFirstPath) {
            if (isTouching(FlxObject.ANY))
                doneFirstPath = true;
            else if (path != null && path.finished)
                doneFirstPath = true;
        }
            

        if (overlaps(_player)) {
            if (_player.heal(health))
                kill();
        }

        super.update(elapsed);
    }

    public function join(otherBall:LightBall):Void {
        path = new FlxPath();
        var points:Array<FlxPoint> = [new FlxPoint(otherBall.x, otherBall.y)];
        path.start(points, 400, FlxPath.FORWARD);
    }

    public function absorb(otherBall:LightBall):Void {
        health += otherBall.health;
        otherBall.kill();
    }

    public function getLightRadius():Float {
        return (baseLight + 3 * Math.sin(Math.floor(_lightcnt++ / 15))) + health;
    }
}