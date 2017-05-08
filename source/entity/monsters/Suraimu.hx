package entity.monsters;

import scene.levels.JsonEntity;
import flixel.FlxObject;
import flixel.FlxG;
import entity.Entity;
import flixel.tile.FlxTilemap;
import entity.suraimu_states.*;
import addons.FlxFSM;
import flixel.group.FlxGroup;

class Suraimu extends Entity {
    var fsm:FlxFSM<Suraimu>;
    var _sticking:Bool = false;
    public var seesPlayer:Bool = false;
    public var nearPlayer:Bool = false;
    public var touchPlayer:Bool = false;
    public var falling:Bool = false;
    public var grounded:Bool = false;
    public var speedFactor:Float;

    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>, graphic:String):Void {
        super(json, player, level, entities);

        loadGraphic(graphic, true, 256, 192);
        rescale();
        
        animation.add("idle", [for (i in 7...14) i], 8, true);
        animation.add("walk", [for (i in 28...35) i], 12, true);
        animation.add("jump", [for (i in 22...27) i], 16, false);
        animation.add("bubble", [for (i in 0...7) i], 24, true);
        animation.add("splash", [for (i in 15...20) i], 8, false);
        animation.add("reco", [for (i in 35...42) i], 8, false);
        animation.play("idle");

        fsm = new FlxFSM<Suraimu>(this);
        fsm.transitions
            .add(Idle, Walk, Conditions.seePlayerWithItsEyes)
            .add(Idle, Jump, Conditions.nearPlayer)
            .add(Idle, Air, Conditions.falling)
            
            .add(Walk, Jump, Conditions.nearPlayer)
            .add(Walk, Air, Conditions.falling)
            .add(Walk, Idle, Conditions.notSeePlayer)
            .add(Walk, Idle, Conditions.touchesPlayer)

            .add(Jump, Air, Conditions.finished)
            .add(Air, Splash, Conditions.grounded)

            .add(Splash, Reco, Conditions.finished)
            .add(Reco, Idle, Conditions.finished)
            
        .start(Idle);

        acceleration.y = 450;

        setFacingFlip(FlxObject.RIGHT, true, false);
        setFacingFlip(FlxObject.LEFT, false, false);
    }

    public override function update(elapsed:Float):Void {
        immovable = false;
        entities.forEachOfType(Suraimu, function(other:Suraimu) {
            FlxG.collide(this, other);
        });
        FlxG.collide(this, _level);
        immovable = true;
        
        grounded = isTouching(FlxObject.DOWN);
        falling = !grounded && velocity.y > 0;
        seesPlayer = Math.abs(x - _player.x) <= FlxG.width / 2 && Math.abs(y - _player.y) <= FlxG.height / 2;
        facing = if (x - _player.x < 0) FlxObject.RIGHT else FlxObject.LEFT;
        nearPlayer = _player.nearBox.containsPoint(getMidpoint()) && !_player.proximityBox.containsPoint(getMidpoint());
        touchPlayer = overlaps(_player);

        if (touchPlayer && !_sticking) {
            stickPlayer();
            _sticking = true;
        } else if (!touchPlayer && _sticking) {
            unStickPlayer();
            _sticking = false;
        }
        
        fsm.update(elapsed);
        super.update(elapsed);
    }

    public function stickPlayer():Void {
        
    }

    public function unStickPlayer():Void {
        
    }
}