package scene;

import flixel.util.FlxSpriteUtil;
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

import entity.obstacles.*;
import entity.monsters.*;
import entity.misc.*;
import entity.Player;
import entity.Entity;

import scene.PauseSubState;

/**
 Helper for creating a level, should be extended by all level class
**/
class ParentState extends FlxState {
    private var _player:Player;
    public var player_start:FlxPoint = new FlxPoint(128, 128);
    var _level:FlxTilemap;
    var _lvlConfig:String;
    var _rect:FlxRect = new FlxRect();

    var _circle:FlxSprite = new FlxSprite();

    var _entities:FlxTypedGroup<Entity> = new FlxTypedGroup<Entity>();
    var _darkness:Darkmap;

    override public function create():Void {
        FlxG.watch.add(FlxG, "worldBounds");
        FlxG.watch.add(this, "subState");

        loadEvents();
        setCamera();

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
            var bg:FlxSprite = new FlxSprite();
            bg.loadGraphic(AssetPaths.grunge__png , true, 715, 250);
            bg.animation.add("def", [for (i in 0...4) i], 24, true);
            bg.animation.play("def");
            bg.setGraphicSize(FlxG.width, FlxG.height);
            bg.updateHitbox();
            bg.scrollFactor.set();
            add(bg);

            _level = new FlxTilemap();
            _level.loadMapFromCSV(tileMap, tileSet, tileWidth, tileHeight);
            
            _player = new Player();

            add(_level);

            FlxG.worldBounds.setSize(_level.width, _level.width);
        }
    
    function loadEvents() {
        var json:scene.levels.EntityList = haxe.Json.parse(_lvlConfig);
        for (obj in json.objects)
        {
            switch (obj.name) {
                case "platform":
                    _entities.add(new Platform(obj.x, obj.y, _player, _level));
                case "stalagmite":
                    _entities.add(new Stalagmite(obj.x, obj.y, _player, _level));
                case "stalagtite":
                    _entities.add(new Stalagtite_ice(obj.x, obj.y, _player, _level));
                case "spawn":
                    player_start.set(obj.x, obj.y);
                case "moveable_blox":
                    _entities.add(new LightCube(obj.x, obj.y, _player, _level));
                case "circle":
                    // _circleFactor.set(obj.width, obj.height);
                case "checkpoint":
                    _entities.add(new Torch(obj.x, obj.y, _player, _level));
                case "ekunaa":
                    _entities.add(new Ekunaa(obj.x, obj.y, _player, _level));
                case "lightball":
                    _entities.add(new LightBall(obj.x, obj.y, _player, _level));
            }
        }

        _player.setPosition(player_start.x, player_start.y);
        _darkness = new Darkmap(0, 0, _player, _entities);
        add(_entities);
        add(_player);
        add(_darkness);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        FlxG.collide(_entities);
        FlxG.collide(_player, _level);

        if (FlxG.keys.anyJustPressed([ESCAPE, P])) {
            openSubState(new PauseSubState(_player, _rect));
            setCamera();
        }

        if (!_player.inWorldBounds())
            _player.kill();

        handleLight();
    }


    function setCamera():Void {
        FlxG.camera.follow(_player, FlxCameraFollowStyle.PLATFORMER);
        _rect = _level.getBounds(_rect);
        FlxG.camera.setScrollBoundsRect(_rect.x, _rect.y, _rect.width, _rect.height);
    }

    function handleLight():Void {
        if (FlxG.mouse.justReleased) {
            if (_player.health > 20 && !FlxFlicker.isFlickering(_player) && _player.canShoot) {
                _player.hurt(5);
                var lilThing:LightBall = null;
                var found = false;
                _entities.forEachDead(function(entity:Entity):Void {
                    if (!found && Std.is(entity, LightBall)) {
                        lilThing = cast (entity, LightBall);
                        lilThing.reset(_player.x, _player.y);
                        lilThing.health = 5;
                        found = true;
                    }
                });
                if (!found) {
                    lilThing = new LightBall(_player.x, _player.y, _player, _level);
                    _entities.add(lilThing);
                }
                var path = new FlxPath();
                var points:Array<FlxPoint> = [new FlxPoint(FlxG.mouse.x, FlxG.mouse.y)];
                lilThing.path = path;
                path.start(points, 400, FlxPath.FORWARD);
            }
        }

        _entities.forEachAlive(function(entity:Entity):Void {
            // lousy overlap check
            if (Std.is(entity, ICollectableLight)) {
                var light = cast (entity, ICollectableLight);
                var rad:Float = light.getLightRadius();
                var rect:FlxRect = new FlxRect(light.center.x - rad, light.center.y - rad, 2*rad, 2*rad);
                if (rect.containsPoint(_player.center)) {
                    _player.health += 1;
                    light.health -= 1;
                }
            }

            if (Std.is(entity, LightBall)) {
                var light = cast (entity, LightBall);
                _entities.forEachOfType(LightBall, function(otherBall:LightBall):Void {
                    if (light != otherBall && otherBall.alive) {
                        if (light.overlaps(otherBall))
                            light.absorb(otherBall);
                        else {
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
        });
    }
}