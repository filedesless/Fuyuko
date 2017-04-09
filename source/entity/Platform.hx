package entity;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import entity.platform_states.*;
import addons.FlxFSM;
import flixel.math.FlxPoint;

class Platform extends FlxSprite {
    public var triggered:Bool = false;
    public var ready:Bool = false;
    public var initialPosition:FlxPoint;
    public var reviveTimer:Int = 0;
    var _player:Player;
    var fsm:FlxFSM<Platform>;

    public override function new(X:Float, Y:Float, player:Player) {
        super(X, Y);
        loadGraphic(AssetPaths.icePlatform__png, false, 64, 64);
        immovable = true;
        _player = player;
        initialPosition = new FlxPoint(X, Y);


        fsm = new FlxFSM<Platform>(this);
        fsm.transitions
            .add(Idle, Triggered, Conditions.isTriggered)
            .add(Triggered, Falling, Conditions.isReady)
            .add(Falling, Done, Conditions.hasHit)
            .add(Done, Idle, Conditions.isAlive)
            .start(Idle);
    }

    public override function update(elapsed:Float) {
        FlxObject.updateTouchingFlags(_player, this);
        fsm.update(elapsed);
        super.update(elapsed);
    }
}