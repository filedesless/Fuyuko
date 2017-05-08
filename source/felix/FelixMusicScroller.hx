package felix;

import flixel.group.FlxSpriteGroup;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.math.FlxRect;

class FelixMusicScroller extends FlxSpriteGroup {
    var _index:Int = 0;
    var list:Array<FlxText> = new Array<FlxText>();
    var _upperRect:FlxRect = new FlxRect(0, 0, 120, 40);
    var _lowerRect:FlxRect = new FlxRect(0, 80, 120, 40);

    var musicPath:String = "assets/music/darkwinter/";

    public override function new (X:Float, Y:Float) {
        super(X, Y);

        var musics:Array<String> = [ 
            "Track1.ogg",
            "Track2.ogg",
            "Track3.ogg",
            "Track4.ogg",
            "Track5.ogg",
            "Track6.ogg",
            "Track7.ogg",
            "Track8.ogg",
            "Track9.ogg",
            "Track10.ogg",
            "Track11.ogg",
            "Track12.ogg",
            "Track13.ogg",
            "Track14.ogg",
            "Track15.ogg",
            "Track16.ogg"
        ];

        for (music in musics) {
            var txt:FlxText = new FlxText(0,0,120, music);
            txt.font = AssetPaths.FantasqueSansMono_Regular__ttf;
            txt.size = 18;
            list.push(txt);
        }
            

        show();
    }

    function show():Void {
        if (_index > 0) {
            list[_index - 1].x = 0;
            list[_index - 1].y = y;
            list[_index - 1].bold = false;
            add(list[_index - 1]);
        }

        list[_index].x = 0;
        list[_index].y = y + 40;
        list[_index].bold = true;
        add(list[_index]);
        felix.FelixSound.stopBackground();
        felix.FelixSound.playBackground(musicPath + list[_index].text, false);
        

        if (_index < list.length-1) {
            list[_index + 1].x = 0;
            list[_index + 1].y = y + 80;
            list[_index + 1].bold = false;
            add(list[_index + 1]);
        }
    }

    public override function update(elapsed:Float):Void {
        if (!felix.FelixSound.isBackgroundPlaying()) {
            
            if (_index == list.length-1) {
                remove(list[_index]);
                if (list.length > 1) remove(list[_index-1]);
                if (list.length > 2) remove(list[_index-2]);
                _index = 0;
            } else {
                if (_index > 0) remove(list[_index-1]);
                _index++;
            }
            trace(_index);
            show();
        }

        if (FlxG.mouse.justReleased) {
            if (_upperRect.containsPoint(FlxG.mouse.getPosition())) {
                if (_index > 0) {
                    if (_index < list.length-1)
                        remove(list[_index+1]);
                    _index--;
                    show();
                }
            } else if (_lowerRect.containsPoint(FlxG.mouse.getPosition())) {
                if (_index < list.length-1) {
                    if (_index > 0)
                        remove(list[_index-1]);
                    _index++;
                    show();
                }
            }
        }

        _upperRect.x = x;
        _upperRect.y = y;
        _lowerRect.x = x;
        _lowerRect.y = y + 80;
    }
}