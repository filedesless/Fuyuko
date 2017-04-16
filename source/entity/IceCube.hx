package entity;

import flixel.tile.FlxTilemap;

class IceCube extends Entity {
    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap) {
        super(X, Y, player, level);
        loadGraphic(AssetPaths.iceCube__png, false, 128, 128);
        immovable = true;
    }
    
}