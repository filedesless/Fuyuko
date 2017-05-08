package entity.misc;

import flixel.tile.FlxTilemap;
import flixel.math.FlxPoint;
import scene.levels.JsonEntity;
import flixel.group.FlxGroup.FlxTypedGroup;

class CrystalBlue extends Entity implements ICollectableLight {
    public var center:FlxPoint = new FlxPoint();

    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.crystal_blue__png, true, 416, 1033);
        rescale();

        baseHealth = health = if (json.health == null) 20 else json.health;

        immovable = true;

        animation.add("full", [for (i in 8...12) i], 4, true);
        animation.add("half", [for (i in 4...8) i], 4, true);
        animation.add("low", [0,1,2,3,2,1,0], 4, true);
        animation.add("empty", [0], 8, true);
        animation.play("full");

        center = getMidpoint(center);
    }

    public override function update(elapsed:Float):Void {
        alive = (health != 0);

        if (health == 0) {
            if (animation.name != "empty")
                animation.play("empty");
        } else if (health < 25) {
            if (animation.name != "low")
                animation.play("low");
        } else if (health < 75) {
            if (animation.name != "half")
                animation.play("half");
        } else {
            if (animation.name != "full")
                animation.play("full");
        }

        super.update(elapsed);
    }

    override public function getLightRadius():Float {
        return (baseLight + _lightStart * Math.sin(Math.floor(_cnt / _lightSpeed))) * health / _player.baseHealth;
    }
}
