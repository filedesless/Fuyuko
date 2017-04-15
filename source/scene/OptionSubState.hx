package scene;

import flixel.FlxCamera;
import flixel.FlxSubState;
import flixel.FlxG;
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

    var _uiVolume:Int = 100;
    var _uiSlider:FlxSlider;

    var i:Int = 0;

    override public function new(bgColor = 0xB0000000) {
        super(bgColor);
    }

    override public function create():Void {
        super.create();

        _backgroundVolume = Math.floor(FelixSound.getBackgroundVolume());
        _sfxVolume = Math.floor(FelixSound.getSfxVolume());
        _ambientVolume = Math.floor(FelixSound.getAmbientVolume());
        _uiVolume = Math.floor(FelixSound.getUiVolume());

        _backgroundSlider = new FlxSlider(
            this, "_backgroundVolume",
            FlxG.camera.width / 2 - 150,
            FlxG.camera.height / 2 - 100 - 15 - 45,
            0, 100, 300, 30, 6,
            FlxColor.WHITE, FlxColor.CYAN);
        _backgroundSlider.setTexts("Volume de la musique");
        _backgroundSlider.scrollFactor.set(); // makes it follow camera around

        _sfxSlider = new FlxSlider(
            this, "_sfxVolume", 
            FlxG.camera.width / 2 - 150,
            FlxG.camera.height / 2 - 15 - 45,
            0, 100, 300, 30, 5,
            FlxColor.WHITE, FlxColor.CYAN);
        _sfxSlider.setTexts("Volume des effets");
        _sfxSlider.scrollFactor.set(); // makes it follow camera around

        _ambientSlider = new FlxSlider(
            this, "_ambientVolume",
            FlxG.camera.width / 2 - 150,
            FlxG.camera.height / 2 - 15 + 45,
            0, 100, 300, 30, 5,
            FlxColor.WHITE, FlxColor.CYAN);
        _ambientSlider.setTexts("Volume ambiant");
        _ambientSlider.scrollFactor.set(); // makes it follow camera around

        _uiSlider = new FlxSlider(
            this, "_uiVolume",
            FlxG.camera.width / 2 - 150,
            FlxG.camera.height / 2 - 15 + 45*3,
            0, 100, 300, 30, 5,
            FlxColor.WHITE, FlxColor.CYAN);
        _uiSlider.setTexts("Volume de l'interface");
        _uiSlider.scrollFactor.set(); // makes it follow camera around

        var btn:FelixMagicButton = new FelixMagicButton(
            null, FlxG.camera.height * 5 / 6, 
            this, "Retour", click_exit
        );

        var btnFullscreen = new FelixMagicButton(
            null, FlxG.camera.height * 1 / 6,
            this, "Plein écran", function():Void { 
                FlxG.fullscreen = !FlxG.fullscreen;
            }
        );

        add(btnFullscreen);

        #if html5
        btnFullscreen.disable();
        #end

        add(btn);
        add(_backgroundSlider);
        add(_sfxSlider);
        add(_ambientSlider);
        add(_uiSlider);
    }
    
    override public function update(elapsed:Float):Void {
        switch (i++) {
            case 15: FelixSound.setBackgroundVolume(_backgroundVolume);
            case 30: FelixSound.setAmbientVolume(_ambientVolume);
            case 45: FelixSound.setSfxVolume(_sfxVolume);
            case 60: FelixSound.setUiVolume(_uiVolume); i = 0;
        }

        if (FlxG.keys.anyJustPressed([ESCAPE])) {
            click_exit();
        }

        super.update(elapsed);
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
        close();
    }
}