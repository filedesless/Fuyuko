package scene;

import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxColor;

import addons.FlxSlider;

import felix.FelixMagicButton;

class DifficultyState extends FlxState {
    var _vitMobs:Float = 1;
    var _vitMobsSlider:FlxSlider;

    var _vitObstacles:Float = 1;
    var _vitObstaclesSlider:FlxSlider;

    var _dmgMobs:Float = 1;
    var _dmgMobsSlider:FlxSlider;

    var _dmgObstacles:Float = 1;
    var _dmgObstaclesSlider:FlxSlider;

    var _health:Float = 1;
    var _healthSlider:FlxSlider;

    var _recoTime:Float = 1;
    var _recoTimeSlider:FlxSlider; 

    var i:Int = 0;

    override public function create():Void {
        super.create();

        _vitMobs = felix.FelixSave.get_vitMob();
        _vitObstacles = felix.FelixSave.get_vitObstacles();

        _vitMobsSlider = new FlxSlider(
            this, "_vitMobs",
            FlxG.camera.width / 2 - 400, 150,
            0.5, 1.5, 300, 30, 6,
            FlxColor.WHITE, FlxColor.CYAN);
        _vitMobsSlider.setTexts("Vitesse des monstres");

        _vitObstaclesSlider = new FlxSlider(
            this, "_vitObstacles",
            FlxG.camera.width / 2 + 100, 150,
            0.5, 1.5, 300, 30, 6,
            FlxColor.WHITE, FlxColor.CYAN);
        _vitObstaclesSlider.setTexts("Vitesse des obstacles mouvants");

        _dmgMobsSlider = new FlxSlider(
            this, "_dmgMobs",
            FlxG.camera.width / 2 - 400, 250,
            0.5, 1.5, 300, 30, 6,
            FlxColor.WHITE, FlxColor.CYAN);
        _dmgMobsSlider.setTexts("Dégâts infligés par les monstres");

        _dmgObstaclesSlider = new FlxSlider(
            this, "_dmgObstacles",
            FlxG.camera.width / 2 + 100, 250,
            0.5, 1.5, 300, 30, 6,
            FlxColor.WHITE, FlxColor.CYAN);
        _dmgObstaclesSlider.setTexts("Dégâts infligés par les obstacles");

        _healthSlider = new FlxSlider(
            this, "_health",
            FlxG.camera.width / 2 - 400, 350,
            0.5, 1.5, 300, 30, 6,
            FlxColor.WHITE, FlxColor.CYAN);
        _healthSlider.setTexts("Points de vie de Fuyuko");

        _recoTimeSlider = new FlxSlider(
            this, "_recoTime",
            FlxG.camera.width / 2 + 100, 350,
            0.5, 1.5, 300, 30, 6,
            FlxColor.WHITE, FlxColor.CYAN);
        _recoTimeSlider.setTexts("Temps de récupération de Fuyuko");

        var btn:FelixMagicButton = new FelixMagicButton(
            null, FlxG.camera.height * 5 / 6, 
            this, "Retour", click_exit
        );

        add(btn);
        add(_vitMobsSlider);
        add(_vitObstaclesSlider);
        add(_dmgMobsSlider);
        add(_dmgObstaclesSlider);
        add(_healthSlider);
        add(_recoTimeSlider);
    }
    
    override public function update(elapsed:Float):Void {
        // switch (i++) {
        //     case 15: felix.FelixSave.set_vitMob(_vitMobs);
        //     case 30: felix.FelixSave.set_ambient_music(_ambientVolume);
        //     case 45: felix.FelixSave.set_sound_effects(_sfxVolume);
        //     case 60: FelixSound.setUiVolume(_uiVolume); i = 0;
        // }

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
        FlxG.switchState(new MenuState());
    }
}