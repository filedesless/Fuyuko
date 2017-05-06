package entity.monsters;

import scene.levels.JsonEntity;
import flixel.FlxObject;
import flixel.FlxG;
import entity.Entity;
import flixel.tile.FlxTilemap;
import entity.suraimu_green_states.*;
import addons.FlxFSM;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;

class SuraimuGreen extends Entity {
    var fsm:FlxFSM<SuraimuGreen>;
    public var seesPlayer:Bool = false;
    public var nearPlayer:Bool = false;
    public var touchPlayer:Bool = false;
    public var falling:Bool = false;
    public var grounded:Bool = false;
    public var freed:Bool = false;
    public var target:FlxPoint = new FlxPoint();

    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>):Void {
        super(json, player, level, entities);

        loadGraphic(AssetPaths.charsheet_suraimu_vert_charsheet__png, true, 256, 192);
        rescale();
        
        animation.add("idle", [for (i in 7...14) i], 8, true);
        animation.add("walk", [for (i in 28...35) i], 12, true);
        animation.add("jump", [for (i in 22...27) i], 16, false);
        animation.add("bubble", [for (i in 0...7) i], 24, true);
        animation.add("splash", [for (i in 15...20) i], 8, false);
        animation.add("reco", [for (i in 35...42) i], 8, false);
        animation.play("idle");

        fsm = new FlxFSM<SuraimuGreen>(this);
        fsm.transitions
            .add(Idle, Walk, Conditions.seePlayer)
            .add(Idle, Jump, Conditions.nearPlayer)
            .add(Idle, Air, Conditions.falling)
            
            .add(Walk, Jump, Conditions.nearPlayer)
            .add(Walk, Air, Conditions.falling)
            .add(Walk, Idle, Conditions.notSeePlayer)

            .add(Jump, Air, Conditions.finished)

            .add(Air, Splash, Conditions.grounded)
            .add(Air, Sticky, Conditions.touchesPlayer)

            .add(Sticky, Fall, Conditions.freed)

            .add(Fall, Splash, Conditions.grounded)

            .add(Splash, Reco, Conditions.finished)

            .add(Reco, Idle, Conditions.finished)
            
        .start(Idle);

        acceleration.y = 600;

        setFacingFlip(FlxObject.RIGHT, true, false);
        setFacingFlip(FlxObject.LEFT, false, false);
    }

    public override function update(elapsed:Float):Void {
        immovable = false;
        FlxG.collide(this, _level);
        grounded = isTouching(FlxObject.DOWN);
        falling = !grounded && velocity.y > 0;
        seesPlayer = Math.abs(x - _player.x) <= FlxG.width / 3 && Math.abs(y - _player.y) <= FlxG.height / 3;
        facing = if (x - _player.x < 0) FlxObject.RIGHT else FlxObject.LEFT;
        nearPlayer = Math.abs(x - _player.x) <= 150 && Math.abs(y - _player.y) <= 150;
        immovable = true;

        touchPlayer = _player.overlapsPoint(getMidpoint());
        if (touchPlayer) target = _player.getMidpoint();
        freed = _player.velocity.x >= 450 || _player.velocity.y >= 100;
        

        fsm.update(elapsed);
        super.update(elapsed);
    }

    public function stickPlayer():Void {
        _player.cantJump = true;
    }

    public function unStickPlayer():Void {
        _player.cantJump = false;
    }
}