package entity.obstacles;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.tile.FlxTilemap;
import flixel.system.FlxSound;

class LightCube extends Entity {
    var _soundChannel:FlxSound = new FlxSound();

    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.lightCube__png, false, 128, 128);
        rescale();
        acceleration.y = 1200;
    }

    public override function update(elapsed:Float):Void {
        immovable = false;
        FlxG.collide(this, _level);

        if (overlaps(_player))
            playerTouchesLightCube();
        else if (_soundChannel.playing)
            _soundChannel.stop();

        immovable = true;
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
            var _direction = if (isTouching(FlxObject.LEFT)) FlxObject.RIGHT else FlxObject.LEFT;
            if (!_soundChannel.playing)
                felix.FelixSound.playGeneric(AssetPaths.lightcube_pushed__ogg, 
                    _soundChannel, felix.FelixSave.get_sound_effects(), false);
            FlxObject.updateTouchingFlags(this, _level); // check if it's in the wall
            if (this.isTouching(_direction)) {
                FlxObject.separate(this, _level);
                _player.velocity.x = 0;
                if (_player.isTouching(_direction)) {
                    FlxObject.separate(_player, this);
                    this.velocity.x = 0; // immobilizes it
                }
                if (_soundChannel.playing) _soundChannel.stop();
            } else {
                this.velocity.x = 0;
            }
        }
    }
}