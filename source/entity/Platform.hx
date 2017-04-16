package entity;

import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import entity.platform_states.*;
import addons.FlxFSM;
import flixel.math.FlxPoint;

class Platform extends Entity {
    public var ready:Bool = false;
    public var initialPosition:FlxPoint;
    public var reviveTimer:Int = 0;
    var fsm:FlxFSM<Platform>;

    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap) {
        super(X, Y, player, level);
        loadGraphic(AssetPaths.icePlatform__png, false, 64, 64);
        immovable = true;
        _player = player;
        initialPosition = new FlxPoint(X, Y);

        fsm = new FlxFSM<Platform>(this);
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