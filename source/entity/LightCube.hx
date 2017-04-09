package entity;

import flixel.FlxSprite;

class LightCube extends FlxSprite {
    public override function new(X:Float, Y:Float) {
        super(X, Y);
        loadGraphic(AssetPaths.movable_bloc__png, false, 128, 128);
        acceleration.y = 200;
    }
    public override function update(elapsed:Float) {
        super.update(elapsed);
    }
}