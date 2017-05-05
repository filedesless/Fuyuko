package entity.monsters;

import flixel.FlxObject;
import flixel.FlxG;
import entity.Entity;
import flixel.tile.FlxTilemap;
import entity.ekunaa_states.*;
import addons.FlxFSM;
import flixel.math.FlxRect;
import flixel.group.FlxGroup;

class Ekunaa extends Entity {
    var fsm:FlxFSM<Ekunaa>;
    public var isTouchingLight:Bool = false;
    public var playerInSight:Bool = false;
    public var direction:Int = FlxObject.LEFT;
    public var entities:FlxTypedGroup<Entity> = new FlxTypedGroup<Entity>();
    var viewBox:FlxRect;

    public override function new(X:Float, Y:Float, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>):Void {
        super(X, Y, player, level);
        this.entities = entities;

        loadGraphic(AssetPaths.charsheet_ekunaa__png, true, 320, 256);
        scale.set(0.45, 0.45);
        updateHitbox();
        solid = true;

        animation.add("idle", [for (i in 0...10) i], 8, true);
        animation.add("walk", [for (i in 10...20) i], 12, true);
        animation.add("charge", [for (i in 20...30) i], 24, true);
        animation.play("idle");

        fsm = new FlxFSM<Ekunaa>(this);
        fsm.transitions
            .add(Wander, Idle, Conditions.isTouchingLight)
            .add(Wander, Charge, Conditions.playerInSight)

            .add(Idle, Wander, Conditions.isNotTouchingLight)

            .add(Charge, Idle, Conditions.isTouchingLight)
            .add(Charge, Idle, Conditions.hitWall)
        .start(Wander);

        acceleration.y = 600;

        setFacingFlip(FlxObject.RIGHT, true, false);
        setFacingFlip(FlxObject.LEFT, false, false);
    }

    public override function update(elapsed:Float):Void {
        immovable = false;
        FlxG.collide(this, _level);
        immovable = true;
        facing = direction;

        if (facing == FlxObject.RIGHT) 
            viewBox = new FlxRect(getMidpoint().x, y - height / 2, FlxG.width * 1.5, height * 2);
        else
            viewBox = new FlxRect(getMidpoint().x - FlxG.width * 1.5, y - height / 2, FlxG.width * 1.5, height * 2);

        playerInSight = viewBox.containsPoint(_player.getMidpoint());

        fsm.update(elapsed);
        FlxObject.updateTouchingFlags(this, _player);
        if (overlaps(_player)) {
            if (isTouching(FlxObject.WALL))
                FlxObject.separate(this, _player);
        }
        super.update(elapsed);
    }
}