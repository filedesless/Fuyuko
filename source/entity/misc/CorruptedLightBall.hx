package entity.misc;

import flixel.FlxG;
import entity.Entity;
import entity.Player;
import flixel.tile.FlxTilemap;

class CorruptedLightBall extends Entity implements ILightSource {
    var _cnt:Int = 0;
    var _lightcnt:Int = 0;
    public var baseLight:Int = 64;

    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap) {
        super(X, Y, player, level);
        loadGraphic(AssetPaths.orb__png, true, 32, 32);

        scale.set(1.5, 1.5);
        updateHitbox();

        health = 5;
        
        animation.add("idle", [1,2,13,14,13,2], 8, true);
        animation.add("idle", [49,50,61,62,61,50], 8, true);
        animation.play("idle");
    }

    public override function update(elapsed:Float):Void {
        velocity.y = Math.sin(_cnt++ * 0.1) * 25;

        immovable = false;
        FlxG.collide(this, _level);
        immovable = true;

        super.update(elapsed);
    }

    public function getLightRadius():Float {
        return (baseLight + 3 * Math.sin(Math.floor(_lightcnt++ / 15))) + health;
    }
}