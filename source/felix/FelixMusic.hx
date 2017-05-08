package felix;

import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.math.FlxRandom;

class FelixMusic extends FlxSprite {
    var list:Array<String> = new Array<String>();
    public var sound:FlxSound = new FlxSound();
    var _rnd:FlxRandom = new FlxRandom();

    var musicPath:String = "assets/music/darkwinter/";

    public override function new() {
        super();

        felix.FelixSound.stopBackground();

        list = [ 
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
    }

    public override function update(elapsed:Float):Void {
        if (!sound.playing) {
            felix.FelixSound.playGeneric(musicPath + list[_rnd.int(0, list.length-1)],
                sound, felix.FelixSave.get_background_music(), false, true);
        }
    }
}