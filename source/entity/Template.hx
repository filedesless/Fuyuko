package entity.misc;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import entity.Entity;
import entity.Player;
import flixel.tile.FlxTilemap;

class Template extends Entity {
    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
    }

    public override function update(elapsed:Float):Void {

        super.update(elapsed);
    }
}