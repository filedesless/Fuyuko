package entity.obstacles;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.FlxG;
import flixel.tile.FlxTilemap;

class Stalagmite extends Entity {
    public var damage:Float = 10;
    
    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
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