package entity.obstacles;

import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.tile.FlxTilemap;

class IceCube extends Entity {
    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.iceCube__png, true, 128, 128);
        rescale();
        immovable = true;
    }

    public function shatter():Void {
        loadGraphic(AssetPaths.icecube_animation__png, true, 128, 128);
        rescale();
        animation.add("break", [for (i in 0...8) i], 6, false);
        animation.play("break");
        animation.finishCallback = function(a:String) { kill(); }
    }
    
}