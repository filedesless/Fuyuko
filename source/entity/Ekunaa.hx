package entity;

import flixel.FlxG;
import entity.Entity;
import flixel.tile.FlxTilemap;

class Ekunaa extends Entity {

    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap):Void {
        super(X, Y, player, level);

        loadGraphic(AssetPaths.charsheet_ekunaa__png, true, 320, 256);
        scale.set(0.45, 0.45);
        updateHitbox();
        flipX = true;
        solid = true;

        animation.add("idle", [for (i in 0...10) i], 8, true);
        animation.add("walk", [for (i in 10...20) i], 12, true);
        animation.add("charge", [for (i in 20...30) i], 24, true);
        animation.play("idle");

        acceleration.y = 600;
    }

    public override function update(elapsed:Float):Void {
        immovable = false;
        FlxG.collide(this, _level);
        immovable = true;
        FlxG.collide(this, _player);
        
        super.update(elapsed);
    }
}