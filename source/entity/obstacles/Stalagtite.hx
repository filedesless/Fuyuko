package entity.obstacles;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.FlxG;
import flixel.tile.FlxTilemap;
import entity.obstacles.stalagtite_states.*;
import addons.FlxFSM;

class Stalagtite extends Entity {
    public var triggered:Bool = false;
    public var ready:Bool = false;
    public var damage:Float = 5;
    var fsm:FlxFSM<Stalagtite>;

    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.iceStalactites__png, false, 128, 128);

        immovable = true;

        fsm = new FlxFSM<Stalagtite>(this);
        fsm.transitions
            .add(Idle, Triggered, Conditions.isTriggered)
            .add(Triggered, Falling, Conditions.isReady)
            .start(Idle);
    }

    public override function update(elapsed:Float) {
        if (_player.x > this.x - 2*64 && _player.x < this.x + 3*64 && 
            _player.y > this.y && _player.y < this.y + 8*64) {
            this.triggered = true;
        }
        
        if (FlxG.pixelPerfectOverlap(_player, this)) {
            _player.hurt(damage * _player.diffFactor);
            kill();
        }

        if (velocity.y > 0)
            if (overlaps(_level)) kill();

        fsm.update(elapsed);
        super.update(elapsed);
    }

}