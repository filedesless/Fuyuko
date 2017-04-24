package entity.misc;

import entity.Entity;
import flixel.math.FlxPoint;
import entity.Player;
import flixel.tile.FlxTilemap;

class LightBall extends Entity implements ILightSource {
    public var baseLight:Int = 64;
    public var center:FlxPoint = new FlxPoint();
    var _cnt:Int = 0;

    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap) {
        super(X, Y, player, level);
        loadGraphic(AssetPaths.orb__png, true, 32, 32);

        health = 100;
        scale.set(3, 3);
        updateHitbox();

        animation.add("idle", [1,2,13,14,13,2], 8, true);
        animation.play("idle");
    }

    public override function update(elapsed:Float):Void {
        _cnt++;
        center = getMidpoint(center);

        trace(health);

        super.update(elapsed);
    }

    public function getLightRadius():Float {
        return (baseLight + 3 * Math.sin(Math.floor((_cnt + 2) / 3))) * health / 100;
    }
}