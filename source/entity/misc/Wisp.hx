package entity.misc;

import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.FlxG;
import entity.Entity;
import entity.Player;
import flixel.tile.FlxTilemap;
import flixel.text.FlxText;

class Wisp extends Entity {
    var _seed:Float;
    var _seedWide:Float;
    public var txt:FlxText;

    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.orb__png, true, 32, 32);
        rescale();
        
        animation.add("idle", [81,82,83,90,91,92,93,94,95,94,93,92,91,90,83,82], 3, true);
        animation.play("idle");

        _seed = rnd.float(0,1000);
        _seedWide = rnd.float(5, 12);

        txt = new FlxText(x, y, 0, _json.desc);
        txt.setFormat(AssetPaths.FantasqueSansMono_Regular__ttf, 16, FlxColor.WHITE, CENTER);
        txt.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);
    }

    public override function update(elapsed:Float):Void {
        velocity.y = Math.sin((_cnt + _seed) / _seedWide) * 25;

        immovable = false;
        FlxG.collide(this, _level);
        immovable = true;

        txt.visible = Math.abs(getMidpoint().x - _player.getMidpoint().x) <= 300 && Math.abs(getMidpoint().y - _player.getMidpoint().y) <= 300;

        txt.x = getMidpoint().x - txt.width / 2;
        txt.y = getMidpoint().y - width * 2;

        super.update(elapsed);
    }
}