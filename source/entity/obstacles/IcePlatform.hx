package entity.obstacles;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import entity.obstacles.ice_platform_states.*;
import addons.FlxFSM;
import flixel.math.FlxPoint;

class IcePlatform extends Entity {
    public var ready:Bool = false;
    public var initialPosition:FlxPoint;
    public var reviveTimer:Int = 0;
    var fsm:FlxFSM<IcePlatform>;

    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.icePlatform__png, false, 64, 64);
        immovable = true;
        initialPosition = new FlxPoint(x, y);

        fsm = new FlxFSM<IcePlatform>(this);
        fsm.transitions
            .add(Idle, Triggered, Conditions.isTriggered)
            .add(Triggered, Falling, Conditions.isReady)
            .add(Falling, Done, Conditions.isInvisible)
            .add(Done, Idle, Conditions.isVisible)
            .start(Idle);
    }

    public override function update(elapsed:Float) {
        if (!visible && ++reviveTimer >= 512) {
            reset(initialPosition.x, initialPosition.y);
            visible = true;
        }

        if (visible) {
            if (overlaps(_player)) {
                if (velocity.y == 0) {
                    FlxObject.separate(this, _player);
                } else visible = false;
            }

            if (overlaps(_level)) visible = false;
        }
        

        fsm.update(elapsed);
        super.update(elapsed);
    }
}