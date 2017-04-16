package entity;

import flixel.FlxSprite;

class Loading extends FlxSprite {
    public override function new(?X:Float, ?Y:Float) {
        super(X, Y);
        loadGraphic(AssetPaths.loading__png, true, 250, 250);
        animation.add("loading", [for (i in 0...12) i], 16, true);
        animation.play("loading");
    }
}