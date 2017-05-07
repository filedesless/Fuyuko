package entity.obstacles;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import scene.levels.JsonEntity;
import flixel.tile.FlxTilemap;

class IceCube extends Entity {
    var _shattering:Bool = false;
    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.iceCube__png, true, 128, 128);
        rescale();
        immovable = true;
    }

    public override function update(elapsed:Float):Void {
        FlxG.collide(this, _player);
        FlxG.collide(this, entities);
        super.update(elapsed);
    }

    public function shatter():Void {
        if (!_shattering) {
            loadGraphic(AssetPaths.icecube_animation__png, true, 128, 128);
            rescale();
            animation.add("break", [for (i in 0...8) i], 12, false);
            animation.play("break");
            animation.finishCallback = function(a:String) { kill(); _shattering = false; }
            _shattering = true;
        }        
    }
    
}