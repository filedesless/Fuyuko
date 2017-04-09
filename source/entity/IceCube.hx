package entity;

import flixel.FlxSprite;

class IceCube extends FlxSprite {
    public override function new(X:Float, Y:Float) {
        super(X, Y);
        loadGraphic(AssetPaths.ice_cube__png, false, 128, 128);
    }
    
}