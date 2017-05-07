package entity.monsters;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.tile.FlxTilemap;

class SuraimuBlue extends Suraimu {
    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>):Void {
        super(json, player, level, entities, AssetPaths.charsheet_suraimu_bleu_charsheet__png);
    }

    override public function stickPlayer():Void {
        _player.cantJump = true;
    }

    override public function unStickPlayer():Void {
        _player.cantJump = false;
    }

    override public function checkFreed():Void {
        freed = _player.velocity.x >= 450 || _player.velocity.y >= 100;
    }
}