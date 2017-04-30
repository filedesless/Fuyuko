package entity.obstacles;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.tile.FlxTilemap;

class ClimbPlatform extends Entity {
    public var damage:Float = 10;
    
    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap) {
        super(X, Y, player, level);
        loadGraphic(AssetPaths.climbPlatform__png, false, 64, 16);
        immovable = true;
        allowCollisions = FlxObject.UP;
    }

    public override function update(elapsed:Float):Void {
        if (_player.animation.name != "crouch")
            FlxG.collide(this, _player);
        super.update(elapsed);
    }
}