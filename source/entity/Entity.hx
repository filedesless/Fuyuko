package entity;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.tile.FlxTilemap;
import scene.levels.JsonEntity;
import entity.misc.ILightSource;
import flixel.math.FlxRandom;

class Entity extends FlxSprite implements ILightSource {
    var _player:Player;
    var _json:JsonEntity;
    var _level:FlxTilemap;
    var _cnt:Float;
    var _lightStart:Float;
    var _lightSpeed:Float;

    public var rnd:FlxRandom;
    public var entities:FlxTypedGroup<Entity>;
    public var baseLight:Int;
    public var baseHealth:Float;

    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json.x, json.y);
        this._cnt = 0;
        this._player = player;
        this._json = json;
        this._level = level;
        this.entities = entities;

        baseLight = if (json.light == null) 0 else json.light;
        baseHealth = health = if (json.health == null) 100 else json.health;  

        rnd = new FlxRandom();
        _lightStart = rnd.float(5, 16);
        _lightSpeed = rnd.float(8, 15);
    }

    function rescale():Void {
        scale.set(_json.scale, _json.scale);
        updateHitbox();
    }

    public override function update(elapsed:Float):Void {
        _cnt++;
        super.update(elapsed);    
    }

    public function getLightRadius():Float {
        var percent = health / baseHealth;
        return if (baseLight == 0) 0 
            else (baseLight + _lightStart * Math.sin(Math.floor(_cnt / _lightSpeed))) * felix.FelixSave.get_light() * if (health >= baseHealth / 2) percent else 0.5;
    }
}