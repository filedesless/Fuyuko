package entity.misc;

import flixel.tile.FlxTilemap;

class EndOfLevel extends Entity {
    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap) {
        super(X, Y, player, level);
        loadGraphic(AssetPaths.iceCube__png);
        immovable = true;
        solid = false;
    }

    public override function update(elapsed:Float):Void {
        if (overlaps(_player)) {
            _player.action = "next_level";
        }
        super.update(elapsed);
    }
}