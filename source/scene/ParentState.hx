package scene;

import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.util.FlxAxes;
import flixel.text.FlxText;
import scene.levels.*;
import flixel.effects.FlxFlicker;
import flixel.util.FlxPath;
import flixel.tile.FlxTilemap;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.group.FlxGroup;

import entity.monsters.*;
import entity.misc.*;
import entity.Player;
import entity.Entity;
import entity.EntityBuilder;

import scene.PauseSubState;

/**
 Helper for creating a level, should be extended by all level class
**/
class ParentState extends FlxState {
    private var _player:Player;
    public var player_start:FlxPoint = new FlxPoint(128, 128);
    var _level:FlxTilemap;
    var _lvlConfig:String;
    var _shokuka:Shokuka;
    var _lvl:Int = 0;

    var _entities:FlxTypedGroup<Entity> = new FlxTypedGroup<Entity>();
    var _darkness:Darkmap;

    override public function new(lvl:Int = 1) {
        super();
        _lvl = lvl;
        _lvlConfig = openfl.Assets.getText('assets/tilemap/Lvl${lvl}.json');

        loadMap('assets/tilemap/Lvl${lvl}.csv');
    }

    override public function create():Void {
        FlxG.camera.antialiasing = felix.FelixSave.get_antialiasing();
        loadEvents();
        FlxG.camera.follow(_player, FlxCameraFollowStyle.PLATFORMER);

        super.create();
    }

    /**
     * Loads the specified map and character into the level.
     * 
     * @param	tileMap 	path of the tilemap (expects a csv) - defaults to assets/tilemap/tilemap.csv
     * @param	tileSet		path of the tileset (expects a png) - defaults to tassets/tilemap/tileset.png
     * @param	tileWidth	width of each tile - defaults to 64
     * @param	tileHeight	height of each tile - defaults to 64
     */
    function loadMap(
        tileMap:String = "assets/tilemap/tilemap.csv", 
        tileSet:String = "assets/tileset/tileset.png", 
        tileWidth:Int = 64,
        tileHeight:Int = 64):Void
        {
            _level = new FlxTilemap();
            _level.loadMapFromCSV(tileMap, tileSet, tileWidth, tileHeight);

            FlxG.worldBounds.setSize(_level.width, _level.width);
        }
    
    function loadEvents() {
        var cnf:JsonEntity = {
            name: "shokuka", desc: "", x:0, y:0,
            light:128, scale:1, damage:0, health:5, moveX:0, moveY:0
        };
        _shokuka = new Shokuka(cnf, _player, _level, _entities);
        var json:EntityList = haxe.Json.parse(_lvlConfig);
        for (obj in json.objects)
            if (obj.name == "Player") _player = new Player(obj, _player, _level, _entities);

        var bg:FlxSprite = new FlxSprite();
        bg.loadGraphic('assets/${json.header.background}');
        add(bg);
        add(_level);

        var title:FlxText = new FlxText(0, 0, 0, json.header.name, 52);
        title.screenCenter(FlxAxes.X);
        title.y = 40;
        title.scrollFactor.set();
        title.setBorderStyle(OUTLINE, FlxColor.BLUE, 2);
        FlxTween.tween(title, { alpha: 0 }, 2, { startDelay: 1 });

        var builder:EntityBuilder = new EntityBuilder(_player, _level, _entities);
        for (obj in json.objects)
            if (obj.name != "Player")
                _entities.add(builder.build(obj));

        _darkness = new Darkmap(0, 0, _player, _entities);
        add(_entities);
        add(_player);
        add(_darkness);
        add(title);

        _entities.forEachOfType(Wisp, function(navy:Wisp):Void {
            add(navy.txt);
        });
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        FlxG.collide(_entities);
        FlxG.collide(_player, _level);

        if (FlxG.keys.anyJustPressed([ESCAPE, P])) {
            openSubState(new PauseSubState(_lvl));
        }

        #if !debug
        if (!_player.inWorldBounds())
            _player.kill();
        #end

        switch (_player.action) {
            case "spawnCorruptedLightBall": spawnCorruptedLightBall();
            case "next_level": next_level();
            case "death": death();
        }
        _player.action = "";

        #if !debug
        if (_level.overlapsPoint(_player.getMidpoint()))
            _player.kill();
        #end

        handleLight();
    }

    function spawnLightBall():Void {
        var lilThing:LightBall = null;
        var found = false;
        _entities.forEachDead(function(entity:Entity):Void {
            if (!found && Std.is(entity, LightBall)) {
                lilThing = cast (entity, LightBall);
                lilThing.reset(_player.x, _player.y);
                lilThing.health = 5;
                lilThing.doneFirstPath = false;
                found = true;
            }
        });
        if (!found) {
            var cnf:JsonEntity = {
                name: "LightBall", desc: "", x:_player.x, y:_player.y,
                light:128, scale:1, damage:0, health:5, moveX:0, moveY:0
            };
            lilThing = new LightBall(cnf, _player, _level, _entities);
            _entities.add(lilThing);
        }
        var path = new FlxPath();
        var points:Array<FlxPoint> = [new FlxPoint(FlxG.mouse.x, FlxG.mouse.y)];
        lilThing.path = path;
        path.start(points, 400, FlxPath.FORWARD);
    }

    function spawnCorruptedLightBall():Void {
        var lilThing:CorruptedLightBall = null;
        var found = false;
        _entities.forEachDead(function(entity:Entity):Void {
            if (!found && Std.is(entity, CorruptedLightBall)) {
                lilThing = cast (entity, CorruptedLightBall);
                lilThing.reset(_player.x, _player.y);
                lilThing.health = 5;
                found = true;
            }
        });
        if (!found) {
            var cnf:JsonEntity = {
                name: "CorruptedLightBall", desc: "", x:_player.x, y:_player.y,
                light:128, scale:1, damage:0, health:5, moveX:0, moveY:0
            };
            lilThing = new CorruptedLightBall(cnf, _player, _level, _entities);
            _entities.add(lilThing);
        }
    }

    function checkCollectableLight(entity:Entity):Void {
        if (entity.alive && Std.is(entity, CrystalBlue)) {
            var light = cast (entity, CrystalBlue);
            if (_player.overlaps(light) && light.health > 0) {
                if (_player.heal(5))
                    _entities.forEachOfType(CrystalBlue, function(otherLight:CrystalBlue):Void {
                        otherLight.health -= 5;
                    });
            }
        }
    }

    function checkLightBall(entity:Entity):Void {
        if (entity.alive && Std.is(entity, LightBall)) {
            var light = cast (entity, LightBall);
            _entities.forEachOfType(LightBall, function(otherBall:LightBall):Void {
                if (light != otherBall && otherBall.alive) {
                    if (light.overlaps(otherBall) && otherBall.doneFirstPath)
                        light.absorb(otherBall);
                    else if (light.doneFirstPath) {
                        var rad1:Float = light.getLightRadius();
                        var mid1:FlxPoint = light.getMidpoint();
                        var rad2:Float = otherBall.getLightRadius();
                        var mid2:FlxPoint = otherBall.getMidpoint();
                        var rect:FlxRect = new FlxRect(mid1.x - rad1, mid1.y - rad1, 2*rad1, 2*rad1);
                        var rect2:FlxRect = new FlxRect(mid2.x - rad2, mid2.y - rad2, 2*rad2, 2*rad2);
                        if (rect.overlaps(rect2)) {
                            light.join(otherBall);
                        }
                    }
                }
            });
        }
    }

    function checkEkunaa(entity:Entity):Void {
        if (entity.alive && Std.is(entity, Ekunaa)) {
            var ekunaa = cast (entity, Ekunaa);
            var found:Bool = false;
            _entities.forEachOfType(LightBall, function(light:LightBall):Void {
                if (light.alive && ekunaa.overlaps(light))
                    found = true;
            });
            ekunaa.isTouchingLight = found;
        }
    }

    function handleLight():Void {
        if (FlxG.mouse.justReleased) {
            if (_player.health > 20 && !FlxFlicker.isFlickering(_player)) {
                _player.decrease_life(5);
                spawnLightBall();
            }
        }

        _entities.forEach(function(entity:Entity):Void {
            // lousy overlap check
            checkCollectableLight(entity);
            checkLightBall(entity);
            checkEkunaa(entity);
        });
    }

    function next_level():Void {
        felix.FelixSave.set_level_completed(_lvl);
        felix.FelixSound.closeSounds();
        FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function() {
            FlxG.camera.fade(FlxColor.TRANSPARENT, 0.5, true);
            FlxG.switchState(new LevelSelectionState(_lvl + 1));
        });
    }

    function death():Void {
        FlxG.switchState(new scene.GameOverSubState(_lvl));
    }
}