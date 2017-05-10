package entity.monsters;

import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import scene.levels.JsonEntity;
import flixel.FlxObject;
import flixel.FlxG;
import entity.Entity;
import flixel.tile.FlxTilemap;
import entity.ekunaa_states.*;
import addons.FlxFSM;
import flixel.math.FlxRect;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;

class Ekunaa extends Entity {
    var fsm:FlxFSM<Ekunaa>;
    public var isTouchingLight:Bool = false;
    public var playerInSight:Bool = false;
    public var direction:Int = FlxObject.LEFT;
    var viewBox:FlxRect;

    var _chargeSound:FlxSound = new FlxSound();
    var _walkSound:FlxSound = new FlxSound();
    var _growlSound:FlxSound = new FlxSound();

    public override function new(json:JsonEntity, player:Player, level:FlxTilemap, entities:FlxTypedGroup<Entity>):Void {
        super(json, player, level, entities);

        loadGraphic(AssetPaths.charsheet_ekunaa__png, true, 320, 256);
        rescale();
        
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

        //_chargeSound = FlxG.sound.load(AssetPaths.ekunaaCharge__ogg,0.003 * felix.FelixSave.get_ambient_music(),false);
        _walkSound = FlxG.sound.load(AssetPaths.ekunaaWalk__ogg,0.003 * felix.FelixSave.get_ambient_music(),false);
        _growlSound = FlxG.sound.load(AssetPaths.ekunaaGrowl__ogg,0.003 * felix.FelixSave.get_ambient_music(),false);

        setFacingFlip(FlxObject.RIGHT, true, false);
        setFacingFlip(FlxObject.LEFT, false, false);
        FlxG.watch.add(this, "direction");
    }

    public override function update(elapsed:Float):Void {
        immovable = false;
        FlxG.collide(this, _level);
        immovable = true;
        facing = direction;
        playGrowl();
        if (facing == FlxObject.RIGHT) 
            viewBox = new FlxRect(getMidpoint().x, y - height / 2, FlxG.width * 1.5, height * 2);
        else
            viewBox = new FlxRect(getMidpoint().x - FlxG.width * 1.5, y - height / 2, FlxG.width * 1.5, height * 2);

        playerInSight = viewBox.containsPoint(_player.getMidpoint());
        
        fsm.update(elapsed);
        FlxObject.updateTouchingFlags(this, _player);
        if (overlaps(_player)) {
            _player.hurt(_json.damage * felix.FelixSave.get_dmgMonster());
            if (isTouching(FlxObject.WALL))
                FlxObject.separate(this, _player);
        }
        if (overlapsPoint(_player.getMidpoint()))
            _player.kill();
        super.update(elapsed);
    }

    public function playWalk():Void{
        if((_cnt) %15 == 0) 
            if(!_walkSound.playing)
            {
                _walkSound.volume = 0.01 * felix.FelixSave.get_ambient_music();
                _walkSound.play();
            }
                
    }

    public function playCharge():Void{
        //if(!_chargeSound.playing)
          //  _chargeSound.play();
    }

    public function playGrowl():Void{
        if((_cnt) %1200 == 0) 
            if(!_growlSound.playing)
            {
                _growlSound.volume = 0.01 * felix.FelixSave.get_ambient_music();
                _growlSound.play();
                
            }
                
    }
}