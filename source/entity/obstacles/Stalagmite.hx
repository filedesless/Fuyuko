package entity.obstacles;

import flixel.FlxG;
import flixel.tile.FlxTilemap;

class Stalagmite extends Entity {
    public var damage:Float = 10;
    
    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap) {
        super(X, Y, player, level);
        loadGraphic(AssetPaths.stalactites__png, false, 128, 128);
        flipY = true;
        immovable = true;
        solid = false;
    }

    public override function update(elapsed:Float):Void {
        if (FlxG.pixelPerfectOverlap(_player, this)) {
            _player.hurt(damage * _player.diffFactor);
        }

        super.update(elapsed);
    }
}