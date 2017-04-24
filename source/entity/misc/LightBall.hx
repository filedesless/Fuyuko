package entity.misc;

import entity.Entity;
import entity.Player;
import flixel.tile.FlxTilemap;

class LightBall extends Entity implements ILightSource {
    var _cnt:Int = 0;
    var _lightcnt:Int = 0;
    public var baseLight:Int = 128;

    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap) {
        super(X, Y, player, level);
        loadGraphic(AssetPaths.orb__png, true, 32, 32);

        scale.set(2, 2);
        updateHitbox();

        animation.add("idle", [1,2,13,14,13,2], 8, true);
        animation.play("idle");
    }

    public override function update(elapsed:Float):Void {
        velocity.y = Math.sin(_cnt++ * 0.1) * 25;
        super.update(elapsed);
    }

    public function getLightRadius():Float {
        return (baseLight + 3 * Math.sin(Math.floor(_lightcnt++ / 15)));
    }
}