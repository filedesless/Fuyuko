package entity.misc;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.FlxG;
import entity.Entity;
import entity.Player;
import flixel.tile.FlxTilemap;

class CorruptedLightBall extends Entity {
    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.orb__png, true, 32, 32);
        rescale();

        health = 5;
        
        animation.add("idle", [1,2,13,14,13,2], 8, true);
        animation.add("idle", [49,50,61,62,61,50], 8, true);
        animation.play("idle");
    }

    public override function update(elapsed:Float):Void {
        velocity.y = Math.sin(_cnt * 0.1) * 25;

        immovable = false;
        FlxG.collide(this, _level);
        immovable = true;

        super.update(elapsed);
    }
}