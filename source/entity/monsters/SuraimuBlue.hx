package entity.monsters;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.tile.FlxTilemap;

class SuraimuBlue extends Suraimu {
    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>):Void {
        super(json, player, level, entities, AssetPaths.charsheet_suraimu_bleu_charsheet__png);
    }

    override public function stickPlayer():Void {
        _player.slowedBy++;
    }

    override public function unStickPlayer():Void {
        _player.slowedBy--;
    }
}