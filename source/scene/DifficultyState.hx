package scene;

import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxColor;

import addons.FlxSlider;

import felix.FelixMagicButton;
import felix.FelixSave;

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

    var _light:Float = 1;
    var _lightSlider:FlxSlider;

    var _brightness:Float = 1;
    var _brightnessSlider:FlxSlider;

    var i:Int = 0;

    override public function create():Void {
        super.create();

        _vitMobs = FelixSave.get_vitMob();
        _vitObstacles = FelixSave.get_vitObstacles();
        _dmgMobs = FelixSave.get_dmgMonster();
        _dmgObstacles = FelixSave.get_dmgObstacles();
        _health = FelixSave.get_health();
        _recoTime = FelixSave.get_recoTime();
        _light = FelixSave.get_light();
        _brightness = FelixSave.get_brightness();

        _vitMobsSlider = new FlxSlider(
            this, "_vitMobs",
            FlxG.camera.width / 2 - 450, 50,
            0.5, 1.5, 300, 30, 6,
            FlxColor.WHITE, FlxColor.CYAN);
        _vitMobsSlider.setTexts("Vitesse des monstres", true, null, null, 14);

        _vitObstaclesSlider = new FlxSlider(
            this, "_vitObstacles",
            FlxG.camera.width / 2 + 150, 50,
            0.5, 1.5, 300, 30, 6,
            FlxColor.WHITE, FlxColor.CYAN);
        _vitObstaclesSlider.setTexts("Vitesse des obstacles mouvants", true, null, null, 14);

        _dmgMobsSlider = new FlxSlider(
            this, "_dmgMobs",
            FlxG.camera.width / 2 - 450, 150,
            0.5, 1.5, 300, 30, 6,
            FlxColor.WHITE, FlxColor.CYAN);
        _dmgMobsSlider.setTexts("Dégâts infligés par les monstres", true, null, null, 14);

        _dmgObstaclesSlider = new FlxSlider(
            this, "_dmgObstacles",
            FlxG.camera.width / 2 + 150, 150,
            0.5, 1.5, 300, 30, 6,
            FlxColor.WHITE, FlxColor.CYAN);
        _dmgObstaclesSlider.setTexts("Dégâts infligés par les obstacles", true, null, null, 14);

        _healthSlider = new FlxSlider(
            this, "_health",
            FlxG.camera.width / 2 - 450, 250,
            0.5, 1.5, 300, 30, 6,
            FlxColor.WHITE, FlxColor.CYAN);
        _healthSlider.setTexts("Points de vie de Fuyuko", true, null, null, 14);

        _recoTimeSlider = new FlxSlider(
            this, "_recoTime",
            FlxG.camera.width / 2 + 150, 250,
            0.5, 1.5, 300, 30, 6,
            FlxColor.WHITE, FlxColor.CYAN);
        _recoTimeSlider.setTexts("Temps de récup. de Fuyuko", true, null, null, 14);

        _lightSlider = new FlxSlider(
            this, "_light",
            FlxG.camera.width / 2 - 450, 350,
            0.5, 1.5, 300, 30, 6,
            FlxColor.WHITE, FlxColor.CYAN);
        _lightSlider.setTexts("Lumière émise par Fuyuko", true, null, null, 14);

        _brightnessSlider = new FlxSlider(
            this, "_brightness",
            FlxG.camera.width / 2 + 150, 350,
            0.5, 1.5, 300, 30, 6,
            FlxColor.WHITE, FlxColor.CYAN);
        _brightnessSlider.setTexts("Luminosité des zones éclairées", true, null, null, 14);

        var btnRetour:FelixMagicButton = new FelixMagicButton(
            FlxG.camera.width / 6, FlxG.camera.height * 5 / 6, 
            this, "Retour", click_exit
        );

        var btnStart:FelixMagicButton = new FelixMagicButton(
            FlxG.camera.width * 4 / 6, FlxG.camera.height * 5 / 6, 
            this, "Suivant", click_start
        );

        add(btnRetour);
        add(btnStart);
        add(_vitMobsSlider);
        add(_vitObstaclesSlider);
        add(_dmgMobsSlider);
        add(_dmgObstaclesSlider);
        add(_healthSlider);
        add(_recoTimeSlider);
        add(_lightSlider);
        add(_brightnessSlider);
    }
    
    override public function update(elapsed:Float):Void {
        _dmgMobs = Math.floor(_dmgMobs/0.5)*0.5;
        _dmgObstacles = Math.floor(_dmgObstacles/0.5)*0.5;
        switch (i++) {
            case 10: felix.FelixSave.set_vitMob(_vitMobs);
            case 20: felix.FelixSave.set_vitObstacles(_vitObstacles);
            case 30: felix.FelixSave.set_dmgMonster(_dmgMobs);
            case 40: felix.FelixSave.set_dmgObstacles(_dmgObstacles);
            case 50: felix.FelixSave.set_health(_health);
            case 60: felix.FelixSave.set_recoTime(_recoTime);
            case 70: felix.FelixSave.set_light(_light);
            case 80: felix.FelixSave.set_brightness(_brightness); i = 0;
        }

        super.update(elapsed);
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
        FlxG.switchState(new scene.levels.Lvl1());
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