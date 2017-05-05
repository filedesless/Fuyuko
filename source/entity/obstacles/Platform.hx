package entity.obstacles;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.tile.FlxTilemap;

class Platform extends Entity {
    public var damage:Float = 10;
    
    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.climbPlatform__png, false, 64, 16);
        rescale();
        immovable = true;
        allowCollisions = FlxObject.UP;
    }

    public override function update(elapsed:Float):Void {
        if (_player.animation.name != "crouch")
            FlxG.collide(this, _player);
        super.update(elapsed);
    }
}