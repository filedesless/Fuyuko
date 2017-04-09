package entity;

import flixel.FlxSprite;

class Stalagmite extends FlxSprite {
    public var damage:Float = 10;
    
    public override function new(X:Float, Y:Float) {
        super(X, Y);
        loadGraphic(AssetPaths.stalactites__png, false, 128, 128);
        flipY = true;
    }
}