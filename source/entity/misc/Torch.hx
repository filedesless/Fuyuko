package entity.misc;

import flixel.tile.FlxTilemap;
import flixel.math.FlxPoint;

class Torch extends Entity implements ICollectableLight {
    public var baseLight:Int = 128;
    public var center:FlxPoint = new FlxPoint();
    var _cnt:Int = 0;

    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap) {
        super(X, Y, player, level);
        loadGraphic(AssetPaths.animated_torch__png, true, 32, 64);

        health = 100;

        animation.add("idle", [for (i in 0...9) i], 12, true);
        animation.play("idle");

        center = getMidpoint(center);
    }

    public override function update(elapsed:Float):Void {
        super.update(elapsed);
    }

    public function getLightRadius():Float {
        return (baseLight + 3 * Math.sin(Math.floor((_cnt++ + 3) / 8))) * (health + 20) / 100;
    }
}
