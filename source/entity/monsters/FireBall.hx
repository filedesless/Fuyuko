package entity.monsters;

import flixel.util.FlxPath;
import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.FlxG;
import entity.Entity;
import entity.Player;
import flixel.tile.FlxTilemap;
import flixel.text.FlxText;
import flixel.math.FlxPoint;

class FireBall extends Entity {
    var _seed:Float;
    var _seedWide:Float;
    public var txt:FlxText;

    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.orb__png, true, 32, 32);
        rescale();

        path = new FlxPath();
        path.start([new FlxPoint(x + json.moveX, y + json.moveY),
                new FlxPoint(x, y)], 60 * felix.FelixSave.get_vitObstacles(), FlxPath.YOYO);

        solid = false;

        baseHealth = health = 10;
        baseLight = 25;
        
        animation.add("idle", [33,34,35,42,43,44,45,46,47,46,45,44,43,42,35,34], 3, true);
        animation.play("idle");

        _seed = rnd.float(0,1000);
        _seedWide = rnd.float(5, 12);
    }

    public override function update(elapsed:Float):Void {
        velocity.y = Math.sin((_cnt + _seed) / _seedWide) * 25;

        immovable = false;
        FlxG.collide(this, _level);
        immovable = true;

        if (overlaps(_player))
            _player.hurt(_json.damage * felix.FelixSave.get_dmgObstacles());

        super.update(elapsed);
    }
}