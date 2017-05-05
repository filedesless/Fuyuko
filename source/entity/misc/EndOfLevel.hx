package entity.misc;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.tile.FlxTilemap;

class EndOfLevel extends Entity {
    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.iceCube__png);
        rescale();
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