package entity.obstacles;

import flixel.tile.FlxTilemap;

class IceCube extends Entity {
    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap) {
        super(X, Y, player, level);
        loadGraphic(AssetPaths.iceCube__png, true, 128, 128);
        immovable = true;
    }

    public function break():Void {
        loadGraphic(AssetPaths.icecube_animation__png, true, 128, 128);
        animation.add("break", [for (i in 0...8) i], 6, false);
        animation.play("break");
        animation.finishCallback = kill
    }
    
}