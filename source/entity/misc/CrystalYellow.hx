package entity.misc;

import flixel.FlxG;
import flixel.tile.FlxTilemap;
import scene.levels.JsonEntity;
import flixel.group.FlxGroup.FlxTypedGroup;

class CrystalYellow extends Entity {
    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>) {
        super(json, player, level, entities);
        loadGraphic(AssetPaths.crystal_yellow__png, true, 416, 1033);
        rescale();

        immovable = true;
        baseHealth = health = if (json.health == null) 20 else json.health;

        animation.add("full", [for (i in 8...12) i], 4, true);
        animation.add("half", [for (i in 4...8) i], 4, true);
        animation.add("low", [0,1,2,3,2,1,0], 4, true);
        animation.add("empty", [0], 8, true);
        animation.play("full");
    }

    public override function update(elapsed:Float):Void {
        FlxG.collide(this, _player);
        entities.forEachAlive(function(entity:Entity):Void {
            if (overlaps(entity) && Std.is(entity, LightBall)) {
                var light:LightBall = cast(entity, LightBall);
                if (health > 0) {
                    hurt(light.health);
                    light.kill();
                }
            }
        });

        if (health <= 0)
            kill();

        if (health == 0) {
            if (animation.name != "empty")
                animation.play("empty");
        } else if (health <= 0.25 * baseLight) {
            if (animation.name != "low")
                animation.play("low");
        } else if (health <= 0.75 * baseLight) {
            if (animation.name != "half")
                animation.play("half");
        } else {
            if (animation.name != "full")
                animation.play("full");
        }

        super.update(elapsed);
    }

    override public function kill():Void {
        var numBalls:Int = Math.floor(baseHealth / 5);
        var cnf:JsonEntity = {
            name: "CorruptedLightBall", desc: "", x:x, y:y,
            light:128, scale:1, damage:0, health:5, moveX:0, moveY:0
        }
        for (i in 0...numBalls) {
            var ball = new CorruptedLightBall(cnf, _player, _level, entities);
            ball.projection(i*2*Math.PI/numBalls);
            entities.add(ball);
        }

        super.kill();
    }

    override public function getLightRadius():Float {
        return (baseLight + _lightStart * Math.sin(Math.floor(_cnt / _lightSpeed))) * health / _json.health;
    }
}
