package entity.monsters;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.tile.FlxTilemap;

class SuraimuGreen extends Suraimu {
    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>):Void {
        super(json, player, level, entities, AssetPaths.charsheet_suraimu_vert_charsheet__png);
    }
}