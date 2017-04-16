package entity;

import flixel.tile.FlxTilemap;


class Torch extends Entity {
    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap) {
        super(X, Y, player, level);
        loadGraphic(AssetPaths.animated_torch__png, true, 32, 64);

        animation.add("idle", [for (i in 0...9) i], 12, true);
        animation.play("idle");
    }
}
