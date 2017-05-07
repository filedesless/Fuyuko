package entity.misc;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.FlxG;
import entity.Entity;
import entity.Player;
import flixel.tile.FlxTilemap;

class Wisp extends Entity {
    var _seed:Float;
    var _seedWide:Float;
    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.orb__png, true, 32, 32);
        rescale();
        
        animation.add("idle", [81,82,83,90,91,92,93,94,95,94,93,92,91,90,83,82], 3, true);
        animation.play("idle");

        _seed = _rnd.float(0,1000);
        _seedWide = _rnd.float(5, 12);
    }

    public override function update(elapsed:Float):Void {
        velocity.y = Math.sin((_cnt + _seed) / _seedWide) * 25;

        immovable = false;
        FlxG.collide(this, _level);
        immovable = true;

        super.update(elapsed);
    }
}