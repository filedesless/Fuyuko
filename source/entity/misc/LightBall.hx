package entity.misc;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.util.FlxPath;
import flixel.FlxG;
import entity.Entity;
import entity.Player;
import flixel.tile.FlxTilemap;

class LightBall extends Entity {
    public var doneFirstPath:Bool = false;
    var _seed:Float;

    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.orb__png, true, 32, 32);
        rescale();

        health = 5;
        
        animation.add("idle", [1,2,13,14,13,2], 8, true);
        animation.play("idle");

        _seed = _rnd.float(0,10);
    }

    public override function update(elapsed:Float):Void {
        velocity.y = Math.sin((_cnt + _seed) * 0.1) * 25;

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
}