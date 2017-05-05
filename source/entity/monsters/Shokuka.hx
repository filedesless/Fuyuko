package entity.monsters;

import scene.levels.JsonEntity;
import flixel.FlxObject;
import entity.misc.CorruptedLightBall;
import entity.misc.LightBall;
import flixel.tile.FlxTilemap;
import entity.misc.CrystalBlue;
import entity.Entity;
import flixel.group.FlxGroup;
import entity.shokuka_states.*;
import addons.FlxFSM;

class Shokuka extends Entity {
    var fsm:FlxFSM<Shokuka>;
    var _lightcnt:Int = 0;
    public var numberOfLights:Int = 0;
    public var checkpoints:Array<CrystalBlue> = new Array<CrystalBlue>();
    var _checkpointsLoaded:Bool = false;

    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>):Void {
        super(json, player, level, entities);

        health = 0;

        fsm = new FlxFSM<Shokuka>(this);
        fsm.transitions
            .add(Idle, Chase, Conditions.seesLight)
            .add(Chase, Report, Conditions.doneChasing)
            .add(Report, Idle, Conditions.reported)
        .start(Idle);

        loadGraphic(AssetPaths.charsheet_shokuka__png, true, 317, 534);

        animation.add("idle", [0,1,2,3,4,5], 8, true);
        animation.play("idle");
    }

    public override function update(elapsed:Float):Void {
        if (!_checkpointsLoaded)
            loadCheckpoints();
            
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
            if (Std.is(entity, CrystalBlue)) {
                FlxObject.updateTouchingFlags(this, entity);
                if (overlaps(entity)) {
                    entities.forEachOfType(CrystalBlue, function(checkpoint:CrystalBlue):Void {
                        checkpoint.health += health;
                    });
                    health = 0;
                }
            }
        });

        fsm.update(elapsed);
        super.update(elapsed);
    }

    public function loadCheckpoints():Void {
        entities.forEachOfType(CrystalBlue, function(crystal:CrystalBlue):Void {
            checkpoints.push(crystal);
        });
    }
}