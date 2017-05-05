package entity;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.tile.FlxTilemap;
import scene.levels.JsonEntity;
import entity.misc.ILightSource;
import flixel.math.FlxRandom;

class Entity extends FlxSprite implements ILightSource {
    var _player:Player;
    var _level:FlxTilemap;
    var _cnt:Float;
    var _lightStart:Float;
    var _lightSpeed:Float;

    public var entities:FlxTypedGroup<Entity>;
    public var baseLight:Int;

    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json.x, json.y);
        this._cnt = 0;
        this._player = player;
        this._level = level;
        this.entities = entities;

        if (json.scale != 1) {
            scale.set(json.scale, json.scale);
            updateHitbox();
        }

        baseLight = json.light;

        var rnd:FlxRandom = new FlxRandom();
        _lightStart = rnd.float(0, 32);
        _lightSpeed = rnd.float(1, 16);
    }

    public override function update(elapsed:Float):Void {
        _cnt++;
        super.update(elapsed);    
    }

    public function getLightRadius():Float {
        return (baseLight + _lightStart * Math.sin(Math.floor(_cnt / _lightSpeed))) * if (health >= 50) health / 100 else 0.5;
    }
}