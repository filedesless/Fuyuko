package scene;

import flixel.tile.FlxTilemap;
import flash.geom.ColorTransform;
import openfl.geom.Rectangle;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
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

    var _entities:FlxTypedGroup<Entity> = new FlxTypedGroup<Entity>();
    
    var _screen:FlxSprite = new FlxSprite();
    var _circle:FlxSprite = new FlxSprite();
    var _circleFactor:FlxPoint = new FlxPoint(1, 1);

    override public function create():Void {
        FlxG.watch.add(FlxG, "worldBounds");
        #if !debug
        FlxG.mouse.visible = false;
        #end
        FlxG.watch.add(this, "subState");

        loadEvents();
        setCamera();

        _screen.makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
        
        add(_screen);

        _circle.makeGraphic(Math.ceil(_screen.width), Math.ceil(_screen.height), 0x150000FF, true);
        FlxSpriteUtil.drawCircle(_circle, -1, -1, 128, FlxColor.BLACK);

        _circle.pixels.colorTransform(
            new Rectangle(0, 0, _circle.width, _circle.height), 
            new ColorTransform(0,0,0,-1,0,0,0,255)
        );
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
                    _circleFactor.set(obj.width, obj.height);
                case "checkpoint":
                    add(new entity.Torch(obj.x, obj.y, _player, _level));
            }
        }

        _player.setPosition(player_start.x, player_start.y);
        add(_entities);
        add(_player);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        _screen.x = _player.x - _screen.width / 2 + _player.width / 2;
        _screen.y = _player.y - _screen.height / 2 + _player.height / 2;

        FlxG.collide(_entities);
        FlxG.collide(_player, _level);

        if (FlxG.keys.anyJustPressed([ESCAPE, P])) {
            openSubState(new PauseSubState(_player, _rect));
            setCamera();
        }

        handleCircle();

        if (!_player.inWorldBounds())
            _player.kill();
    }

    function handleCircle():Void {
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

}