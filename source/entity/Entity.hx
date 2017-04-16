package entity;

import flixel.FlxSprite;
import flixel.tile.FlxTilemap;

class Entity extends FlxSprite {
    var _player:Player;
    var _level:FlxTilemap;

    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap) {
        super(X, Y);
        _player = player;
        _level = level;
    }
}