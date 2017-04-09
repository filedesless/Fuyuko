package entity;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxSprite;
import entity.stalagtite_ice_states.*;
import addons.FlxFSM;

class Stalagtite_ice extends FlxSprite {
    public var triggered:Bool = false;
    public var ready:Bool = false;
    public var damage:Float = 5;
    var _player:Player;
    var fsm:FlxFSM<Stalagtite_ice>;

    public override function new(X:Float, Y:Float, player:Player) {
        super(X, Y);
        loadGraphic(AssetPaths.stalactites_ice__png, false, 128, 128);
        _player = player;

        fsm = new FlxFSM<Stalagtite_ice>(this);
        fsm.transitions
            .add(Idle, Triggered, Conditions.isTriggered)
            .add(Idle, Done, Conditions.hasHit)
            .add(Triggered, Falling, Conditions.isReady)
            .add(Triggered, Done, Conditions.hasHit)
            .add(Falling, Done, Conditions.hasHit)
            .start(Idle);
    }

    public override function update(elapsed:Float) {
        if (_player.x > this.x - 2*64 && _player.x < this.x + 3*64 && 
            _player.y > this.y && _player.y < this.y + 8*64) {
            this.triggered = true;
        }
        FlxObject.updateTouchingFlags(_player, this);
        fsm.update(elapsed);
        super.update(elapsed);
    }

}