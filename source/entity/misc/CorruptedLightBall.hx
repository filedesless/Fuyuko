package entity.misc;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.FlxG;
import entity.Entity;
import entity.Player;
import flixel.tile.FlxTilemap;

class CorruptedLightBall extends Entity {
    var _seed:Float;
    var _projecting:Bool = false;
    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.orb__png, true, 32, 32);
        rescale();

        health = if (json.health == null) 5 else json.health;

        baseLight = 25;

        animation.add("idle", [49,50,61,62,61,50], 8, true);
        animation.play("idle");

        _seed = rnd.float(0,10);
    }

    public override function update(elapsed:Float):Void {
        if (!_projecting)
            velocity.y = Math.sin((_cnt + _seed) * 0.1) * 25;
        else if (velocity.y == 0) _projecting = false;

        immovable = false;
        FlxG.collide(this, _level);
        immovable = true;

        super.update(elapsed);
    }

    public function projection(angle:Float) {
        velocity.set(Math.cos(angle)*200, Math.sin(angle)*200);
        drag.set(100, 100);
        _projecting = true;
    }
}