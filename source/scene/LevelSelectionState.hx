package scene;

import flixel.math.FlxRect;
import flixel.FlxSprite;
import flixel.util.FlxAxes;
import scene.levels.EntityList;
import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.group.FlxSpriteGroup;

import felix.FelixMagicButton;
import felix.FelixSave;

import sys.FileSystem;
import sys.io.File;

using StringTools;

class LevelSelectionState extends FlxState {
    var _group:FlxSpriteGroup = new FlxSpriteGroup();
    var _spriteGroup:FlxSpriteGroup = new FlxSpriteGroup();
    var _lvlChosen:Int = 1;
    var i:Int = 0;

    override public function create():Void {
        super.create();
        FlxG.camera.antialiasing = felix.FelixSave.get_antialiasing();
        
        var fileList = FileSystem.readDirectory("assets/tilemap/");
        fileList = fileList.filter(function(f:String):Bool { return f.endsWith(".json"); });

        var i:Int = 0, j:Int = 1, cnt:Int = 0;
        for (file in fileList) {
            var json:EntityList = haxe.Json.parse(File.getContent("assets/tilemap/" + file));
            var btn = new felix.FelixLvlButton(300*i++, 200*j, json.header);
            _group.add(btn);
            
            var sprite:FlxSprite = new FlxSprite();
            sprite.makeGraphic(Math.ceil(btn.width) + 80, Math.ceil(btn.height) + 50, FlxColor.TRANSPARENT, true);
            sprite.setPosition(btn.x - 2, btn.y - 30);
            _spriteGroup.add(sprite);

            if (i % 3 == 0) { i = 0; j++; }
            cnt++;
        }
        _group.screenCenter(FlxAxes.X);
        _spriteGroup.screenCenter(FlxAxes.X);
        add(_group);
        add(_spriteGroup);

        var btnRetour:FelixMagicButton = new FelixMagicButton(
            FlxG.camera.width / 6, FlxG.camera.height * 5 / 6, 
            this, "Retour", click_exit
        );

        var btnStart:FelixMagicButton = new FelixMagicButton(
            FlxG.camera.width * 5 / 6 - btnRetour.width, FlxG.camera.height * 5 / 6, 
            this, "Jouer!", click_start
        );

        drawLines();

        add(btnRetour);
        add(btnStart);

    }
    
    override public function update(elapsed:Float):Void {
        if (FlxG.mouse.pressed) {
            var cnt:Int = 1;
            for (sprite in _spriteGroup) {
                var rect:FlxRect = new FlxRect(sprite.x, sprite.y, sprite.width, sprite.height);
                if (rect.containsPoint(FlxG.mouse.getPosition()))
                {
                    _lvlChosen = cnt;
                    drawLines();
                }
                cnt++;
            }
        }
        super.update(elapsed);
    }

    function drawLines():Void {
        var cnt:Int = 1;
        for (sprite in _spriteGroup) {
            if (cnt == _lvlChosen) {
                FlxSpriteUtil.drawRect(sprite, 0, 0, sprite.width, sprite.height, FlxColor.TRANSPARENT, { thickness: 10, color: FlxColor.RED });
            } else {
                sprite.makeGraphic(Math.ceil(sprite.width), Math.ceil(sprite.height), FlxColor.TRANSPARENT, true);
                sprite.setPosition(sprite.x, sprite.y);
            }
            cnt++;
        }
    }

    function click_start():Void {
        #if html5
        exit();
        #else
        FlxG.camera.fade(FlxColor.BLACK, 0.5, false, start);
        #end
    }

    function start():Void {
        #if !html5
        FlxG.camera.fade(FlxColor.TRANSPARENT, 0.5, true);
        #end
        FlxG.switchState(new ParentState(_lvlChosen));
    }

    function click_exit():Void {
        #if html5
        exit();
        #else
        FlxG.camera.fade(FlxColor.BLACK, 0.5, false, exit);
        #end
    }

    function exit():Void {
        #if !html5
        FlxG.camera.fade(FlxColor.TRANSPARENT, 0.5, true);
        #end
        FlxG.switchState(new DifficultyState());
    }
}