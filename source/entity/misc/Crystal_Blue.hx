package entity.misc;

import flixel.tile.FlxTilemap;
import flixel.math.FlxPoint;

class Crystal_Blue extends Entity implements ICollectableLight {
    public var baseLight:Int = 128;
    public var center:FlxPoint = new FlxPoint();
    var _cnt:Int = 0;

    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap) {
        super(X, Y, player, level);
        loadGraphic(AssetPaths.crystal_blue__png, true, 416, 1033);

        scale.set(0.12, 0.12);
        updateHitbox();

        immovable = true;

        health = 100;

        animation.add("full", [for (i in 8...12) i], 4, true);
        animation.add("half", [for (i in 4...8) i], 4, true);
        animation.add("low", [0,1,2,3,2,1,0], 4, true);
        animation.play("full");

        center = getMidpoint(center);
    }

    public override function update(elapsed:Float):Void {
        trace(health);
        if (animation.name != "half" && health < 75)
            animation.play("half");
        else if (animation.name != "low" && health < 25)
            animation.play("low");
        else if (animation.name != "full" && health > 75)
            animation.play("full");

        super.update(elapsed);
    }

    public function getLightRadius():Float {
        return (baseLight + 3 * Math.sin(Math.floor((_cnt++ + 2) / 18))) * if (health >= 40) health / 100 else 0.4;
    }
}
