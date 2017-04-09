package scene;

import flixel.FlxCamera;
import flixel.FlxSubState;
import flixel.FlxG;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

import addons.FlxSlider;

import felix.FelixMagicButton;
import felix.FelixSound;

class OptionSubState extends FlxSubState {
    var _backgroundVolume:Int = 100;
    var _backgroundSlider:FlxSlider;
    var _sfxVolume:Int = 100;
    var _sfxSlider:FlxSlider;
    var _ambientVolume:Int = 100;
    var _ambientSlider:FlxSlider;
    var _camera:FlxCamera;
    var i:Int = 0;

    override public function new(bgColor = 0xB0000000) {
        super(bgColor);
    }

    override public function create():Void {
        super.create();
        
        _camera = FlxG.camera.copyFrom(FlxG.camera);
        FlxG.cameras.reset();

        _backgroundVolume = Math.floor(FelixSound.getBackgroundVolume());
        _sfxVolume = Math.floor(FelixSound.getSfxVolume());
        _ambientVolume = Math.floor(FelixSound.getAmbientVolume());

        _backgroundSlider = new FlxSlider(
            this, "_backgroundVolume",
            FlxG.camera.width / 2 - 150,
            FlxG.camera.height / 2 - 100 - 15 - 45,
            0, 100, 300, 30, 6,
            FlxColor.WHITE, FlxColor.BLUE);
        _backgroundSlider.setTexts("Volume de la musique");

        _sfxSlider = new FlxSlider(
            this, "_sfxVolume", 
            FlxG.camera.width / 2 - 150,
            FlxG.camera.height / 2 - 15 - 45,
            0, 100, 300, 30, 5,
            FlxColor.WHITE, FlxColor.BLUE);
        _sfxSlider.setTexts("Volume des effets");

        _ambientSlider = new FlxSlider(
            this, "_ambientVolume",
            FlxG.camera.width / 2 - 150,
            FlxG.camera.height / 2 - 15 + 45,
            0, 100, 300, 30, 5,
            FlxColor.WHITE, FlxColor.BLUE);
        _ambientSlider.setTexts("Volume ambiant");

        var btn:FelixMagicButton = new FelixMagicButton(
            null, FlxG.camera.height * 5 / 6, 
            this, "Retour", exit
        );

        add(new FelixMagicButton(
            null, FlxG.camera.height * 1 / 6,
            this, "Plein écran", function():Void { 
                FlxG.fullscreen = !FlxG.fullscreen;
            }
        ));

        add(btn);
        add(_backgroundSlider);
        add(_sfxSlider);
        add(_ambientSlider);
    }
    
    override public function update(elapsed:Float):Void {
        switch (i++) {
            case 20: FelixSound.setBackgroundVolume(_backgroundVolume);
            case 40: FelixSound.setAmbientVolume(_ambientVolume);
            case 60: FelixSound.setSfxVolume(_sfxVolume); i = 0;
        }

        if (FlxG.keys.anyJustPressed([ESCAPE])) {
            exit();
        }

        super.update(elapsed);
    }

    function exit():Void {
        FlxG.camera = FlxG.camera.copyFrom(_camera);
        close();
    }
}