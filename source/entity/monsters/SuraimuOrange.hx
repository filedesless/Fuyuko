package entity.monsters;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.tile.FlxTilemap;

class SuraimuOrange extends Suraimu {
    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>):Void {
        super(json, player, level, entities, AssetPaths.charsheet_suraimu_orange__png);
    }

    override public function stickPlayer():Void {
        _player.hurt(_json.damage);
        _sticking = false;
    }

    override public function unStickPlayer():Void {
        
    }
}