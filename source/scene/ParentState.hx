package scene;

import flixel.tile.FlxTilemap;
import flash.geom.ColorTransform;
import openfl.geom.Rectangle;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.group.FlxGroup;

import entity.*;

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
    var _stalagmites:FlxTypedGroup<Stalagmite> = new FlxTypedGroup<Stalagmite>();
    var _lightCubes:FlxTypedGroup<LightCube> = new FlxTypedGroup<LightCube>();
    var _stalagtites_ice:FlxTypedGroup<Stalagtite_ice> = new FlxTypedGroup<Stalagtite_ice>();
    var _iceCubes:FlxTypedGroup<IceCube> = new FlxTypedGroup<IceCube>();
    var _platforms:FlxTypedGroup<Platform> = new FlxTypedGroup<Platform>();
    var _entities:FlxGroup = new FlxGroup();
    var _screen:FlxSprite = new FlxSprite();
    var _circle:FlxSprite = new FlxSprite();
    var _circleFactor:FlxPoint = new FlxPoint(1, 1);

    var _diffFactor:Float = 1;

    override public function create():Void {
        FlxG.watch.add(FlxG, "worldBounds");
        FlxG.mouse.visible = false;
        FlxG.watch.add(this, "subState");

        loadEvents();
        setCamera();

        _screen.makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
        
        add(_screen);

        _circle.makeGraphic(Math.ceil(_screen.width), Math.ceil(_screen.height), 0x150000FF, true);
        FlxSpriteUtil.drawCircle(_circle, -1, -1, 128, FlxColor.BLACK);

        _circle.pixels.colorTransform(new Rectangle(0, 0, _circle.width, _circle.height), new ColorTransform(0,0,0,-1,0,0,0,255));
        FlxSpriteUtil.alphaMaskFlxSprite(_screen, _circle, _screen);

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
                    _platforms.add(new Platform(obj.x, obj.y, _player));
                case "stalagmite":
                    _stalagmites.add(new Stalagmite(obj.x, obj.y));
                case "stalagtite":
                    _stalagtites_ice.add(new Stalagtite_ice(obj.x, obj.y, _player));
                case "spawn":
                    player_start.set(obj.x, obj.y);
                case "moveable_blox":
                    _lightCubes.add(new LightCube(obj.x, obj.y));
                case "circle":
                    _circleFactor.set(obj.width, obj.height);
            }
        }

        _entities.add(_lightCubes);
        _entities.add(_stalagtites_ice);
        _entities.add(_iceCubes);
        _entities.add(_platforms);
        _player.setPosition(player_start.x, player_start.y);
        _entities.add(_player);
        _entities.add(_stalagmites);
        add(_entities);
    }

    override public function update(elapsed:Float):Void {
        _screen.x = _player.x - _screen.width / 2 + _player.width / 2;
        _screen.y = _player.y - _screen.height / 2 + _player.height / 2;

        FlxG.collide(_entities, _level);
        FlxG.collide(_player, _platforms);

        for (_stalagmite in _stalagmites)
            if (FlxG.pixelPerfectOverlap(_player, _stalagmite))
                _player.hurt(_stalagmite.damage * _diffFactor);

        _stalagtites_ice.forEachExists(function(_stalagtite:Stalagtite_ice):Void {
            if (FlxG.pixelPerfectOverlap(_player, _stalagtite))
                _player.hurt(_stalagtite.damage * _diffFactor);
        });

        for (_lightCube in _lightCubes)
            if (FlxG.overlap(_lightCube, _player))
                playerTouchesLightCube(_lightCube);

        _platforms.forEachAlive(function(_platform:Platform):Void {
            FlxObject.updateTouchingFlags(_platform, _level);
        });

        _platforms.forEachDead(function(_platform:Platform):Void {
            if (++_platform.reviveTimer >= 512) {
                _platform.reset(_platform.initialPosition.x, _platform.initialPosition.y);
            }
        });

        if (FlxG.keys.anyJustPressed([ESCAPE, P])) {
            openSubState(new PauseSubState(_player, _rect));
            setCamera();
        }


        handleCircle();

        super.update(elapsed);
    }

    function handleCircle():Void {
        var _max:Float = 300;
        _screen.scale.set(
            _circleFactor.x * (_player.health + 40) / 50,
            _circleFactor.y * (_player.health + 40) / 50
        );
    }

    function setCamera():Void {
        FlxG.camera.follow(_player, FlxCameraFollowStyle.PLATFORMER);
        _rect = _level.getBounds(_rect);
        FlxG.camera.setScrollBoundsRect(_rect.x, _rect.y, _rect.width, _rect.height);
    }

    function playerTouchesLightCube(theCube:LightCube) {
        FlxObject.separate(theCube, _player); // moves the cube
        if (theCube.isTouching(FlxObject.UP)) {
            FlxObject.updateTouchingFlags(theCube, _level); // check if it's in the floor
            if (theCube.isTouching(FlxObject.DOWN)) {
                FlxObject.separate(theCube, _level);
                _player.velocity.set();
                if (_player.isTouching(FlxObject.DOWN)) {
                    FlxObject.separate(_player, theCube);
                    // theCube.velocity.set(); // immobilizes it
                }
            } else {
                theCube.velocity.set();
            }
        } else {
            FlxObject.updateTouchingFlags(theCube, _level); // check if it's in the wall
            if (theCube.isTouching(_player.facing)) {
                FlxObject.separate(theCube, _level);
                _player.velocity.x = 0;
                if (_player.isTouching(_player.facing)) {
                    FlxObject.separate(_player, theCube);
                    theCube.velocity.x = 0; // immobilizes it
                }
            } else {
                theCube.velocity.x = 0;
            }
        }
    }
}