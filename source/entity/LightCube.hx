package entity;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.tile.FlxTilemap;
import flixel.system.FlxSound;

class LightCube extends Entity {
    var _soundChannel:FlxSound = new FlxSound();

    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap) {
        super(X, Y, player, level);
        loadGraphic(AssetPaths.lightCube__png, false, 128, 128);
        acceleration.y = 1200;
    }

    public override function update(elapsed:Float):Void {
        FlxG.collide(this, _level);

        if (overlaps(_player))
            playerTouchesLightCube();

        super.update(elapsed);
    }

    function playerTouchesLightCube() {       
        FlxObject.separate(this, _player); // moves the cube
        if (this.isTouching(FlxObject.UP)) {
            FlxObject.updateTouchingFlags(this, _level); // check if it's in the floor
            if (this.isTouching(FlxObject.DOWN)) {
                FlxObject.separate(this, _level);
                _player.velocity.set();
                if (_player.isTouching(FlxObject.DOWN)) {
                    FlxObject.separate(_player, this);
                    // theCube.velocity.set(); // immobilizes it
                }
            } else {
                this.velocity.set();
            }
        } else {
            if (!_soundChannel.playing)
                felix.FelixSound.playGeneric(AssetPaths.lightcube_pushed__ogg, 
                    _soundChannel, felix.FelixSave.get_sound_effects(), false);
            FlxObject.updateTouchingFlags(this, _level); // check if it's in the wall
            if (this.isTouching(_player.facing)) {
                FlxObject.separate(this, _level);
                _player.velocity.x = 0;
                if (_player.isTouching(_player.facing)) {
                    FlxObject.separate(_player, this);
                    this.velocity.x = 0; // immobilizes it
                }
            } else {
                this.velocity.x = 0;
            }
        }
    }
}