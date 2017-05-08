package entity;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import scene.levels.JsonEntity;
import entity.misc.*;
import entity.monsters.*;
import entity.obstacles.*;

class EntityBuilder {
    var _player:Player;
    var _level:FlxTilemap;
    var _entities:FlxTypedGroup<Entity>;

    public function new(player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        _player = player;
        _level = level;
        _entities = entities;
    }

    public function build(json:JsonEntity):Entity {
        return switch (json.name) {
            case "IcePlatform": new IcePlatform(json, _player, _level, _entities);
            case "Stalagmite": new Stalagmite(json, _player, _level, _entities);
            case "Stalagtite": new Stalagtite(json, _player, _level, _entities);
            case "LightCube": new LightCube(json, _player, _level, _entities);
            case "IceCube": new IceCube(json, _player, _level, _entities);
            case "CrystalBlue": new CrystalBlue(json, _player, _level, _entities);
            case "CrystalRed": new CrystalRed(json, _player, _level, _entities);
            case "CrystalYellow": new CrystalYellow(json, _player, _level, _entities);
            case "Ekunaa": new Ekunaa(json, _player, _level, _entities);
            case "LightBall": new LightBall(json, _player, _level, _entities);
            case "Wisp": new Wisp(json, _player, _level, _entities);
            case "FireBall": new FireBall(json, _player, _level, _entities);
            case "Shokuka": new Shokuka(json, _player, _level, _entities);
            case "SuraimuGreen": new SuraimuGreen(json, _player, _level, _entities);
            case "SuraimuOrange": new SuraimuOrange(json, _player, _level, _entities);
            case "SuraimuBlue": new SuraimuBlue(json, _player, _level, _entities);
            case "Platform": new Platform(json, _player, _level, _entities);
            case "EndOfLevel": new EndOfLevel(json, _player, _level, _entities);
            case _: throw "Objet JSON invalide: " + json.name;
        }
    }
}