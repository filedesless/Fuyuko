package entity.monsters;

import flixel.FlxObject;
import entity.misc.CorruptedLightBall;
import entity.misc.LightBall;
import flixel.tile.FlxTilemap;
import entity.misc.ILightSource;
import entity.misc.Crystal_Blue;
import entity.Entity;
import flixel.group.FlxGroup;
import entity.shokuka_states.*;
import addons.FlxFSM;

class Shokuka extends Entity implements ILightSource {
    public var baseLight:Int = 100;
    var fsm:FlxFSM<Shokuka>;
    var _lightcnt:Int = 0;
    public var numberOfLights:Int = 0;
    public var entities:FlxTypedGroup<Entity> = new FlxTypedGroup<Entity>();
    public var checkpoints:Array<Crystal_Blue> = new Array<Crystal_Blue>();

    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>):Void {
        super(X, Y, player, level);
        this.entities = entities;

        health = 0;

        fsm = new FlxFSM<Shokuka>(this);
        fsm.transitions
            .add(Idle, Chase, Conditions.seesLight)
            .add(Chase, Report, Conditions.doneChasing)
            .add(Report, Idle, Conditions.reported)
        .start(Idle);

        loadGraphic(AssetPaths.charsheet_shokuka__png, true, 317, 534);
        scale.set(0.2, 0.2);
        updateHitbox();

        animation.add("idle", [0,1,2,3,4,5], 8, true);
        animation.play("idle");
    }

    public override function update(elapsed:Float):Void {
        numberOfLights = 0;
        entities.forEach(function(entity:Entity) {
            if (entity.alive)
                if (Std.is(entity, LightBall) || Std.is(entity, CorruptedLightBall)) {
                    if (overlaps(entity)) {
                        health += entity.health;
                        entity.kill();
                    } else
                        ++numberOfLights;
                }
            if (Std.is(entity, Crystal_Blue)) {
                FlxObject.updateTouchingFlags(this, entity);
                if (overlaps(entity)) {
                    entities.forEachOfType(Crystal_Blue, function(checkpoint:Crystal_Blue):Void {
                        checkpoint.health += health;
                    });
                    health = 0;
                }
            }
        });

        fsm.update(elapsed);
        super.update(elapsed);
    }

    public function getLightRadius():Float {
        return (baseLight + 11 * Math.sin(Math.floor(_lightcnt++ / 17))) + health;
    }

    public function loadCheckpoints():Void {
        entities.forEachOfType(Crystal_Blue, function(crystal:Crystal_Blue):Void {
            checkpoints.push(crystal);
        });
    }
}