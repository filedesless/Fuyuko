package entity.obstacles;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.tile.FlxTilemap;

class Stalagmite extends Entity {    
    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.stalactites__png, false, 128, 128);
        rescale();
        flipY = true;
        immovable = true;
        solid = false;
    }

    public override function update(elapsed:Float):Void {
        if (overlaps(_player)) {
            _player.hurt(_json.damage * _player.diffFactor);
        }

        super.update(elapsed);
    }
}