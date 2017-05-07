package entity.misc;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.tile.FlxTilemap;

class EndOfLevel extends Entity {
    var _seed:Float;
    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.orb__png, true, 32, 32);
        rescale();
        
        animation.add("idle", [81,82,83,90,91,92,93,94,95,94,93,92,91,90,83,82], 3, true);
        animation.play("idle");

        _seed = rnd.float(0,10);
    }

    public override function update(elapsed:Float):Void {
        velocity.y = Math.sin((_cnt + _seed) * 0.1) * 25;

        immovable = false;
        FlxG.collide(this, _level);
        immovable = true;

        if (overlaps(_player)) {
            _player.action = "next_level";
        }

        super.update(elapsed);
    }
}