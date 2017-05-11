package scene;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxAxes;

import felix.FelixMagicButton;

import flash.system.System;

/*
    Entry point of the game; main menu
*/
class MenuState extends FlxState
{
    var btnNewGame:FelixMagicButton;
    var btnBonus:FelixMagicButton;
    var btnOptions:FelixMagicButton;
    var btnBestiaire:FelixMagicButton;
    var btnQuitter:FelixMagicButton;
    var _flxMusic:felix.FelixMusic;

    override public function create():Void
    {
        super.create();
        FlxG.camera.antialiasing = felix.FelixSave.get_antialiasing();
        persistentDraw = false;
        FlxG.scaleMode = new flixel.system.scaleModes.FillScaleMode();
        FlxG.watch.addMouse();
        FlxG.watch.add(FlxG.save, "data");
        
        #if mac
        if (!felix.FelixSave.get_setup_done()) {
            Sys.command("defaults write -g ApplePressAndHoldEnabled -bool false");
        }
        #end

        var bg:FlxSprite = new FlxSprite();
        bg.loadGraphic(AssetPaths.cherry_blossom__png, true, 480, 180);
        bg.animation.add("def", [for (i in 0...90) i], 24, true);
        bg.animation.play("def");
        bg.setGraphicSize(FlxG.width, FlxG.height);
        bg.updateHitbox();
        add(bg);

        bgColor = FlxColor.TRANSPARENT;

        // starts music
        _flxMusic = new felix.FelixMusic();

        var logo = new FlxSprite(0, 0, AssetPaths.logo_transparent__png);
        logo.setGraphicSize(600);
        logo.updateHitbox();
        logo.screenCenter(FlxAxes.X);
        logo.y += 30;
        add(logo);

        btnOptions = new FelixMagicButton(
            FlxG.camera.width / 2 + 20,
            FlxG.camera.height * 5 / 12,
            this, "Options", clickOptions
        );

        btnNewGame = new FelixMagicButton(
            FlxG.camera.width / 2 - btnOptions.width - 20,
            FlxG.camera.height * 5 / 12,
            this, "Jouer", clickPlay, 26
        );

        btnBestiaire = new FelixMagicButton(
            FlxG.camera.width / 2 - btnOptions.width - 20,
            FlxG.camera.height * 6 / 11,
            this, "Bestiaire", clickBestiaire
        );

        btnBonus = new FelixMagicButton(
            FlxG.camera.width / 2 + 20,
            FlxG.camera.height * 6 / 11,
            this, "Bonus", clickBonus
        );
     
        btnQuitter = new FelixMagicButton(
            null,
            FlxG.camera.height * 7 / 10,
            this, "Quitter", quitter
        );
        #if html5
        btnQuitter.disable();
        #end

        add(btnNewGame);
        add(btnBonus);
        add(btnBestiaire);
        add(btnOptions);
        add(btnQuitter);
    }

    override public function update(elapsed:Float):Void
    {
        _flxMusic.update(elapsed);
        super.update(elapsed);
    }

    // starts game in a second
    function clickPlay():Void {
        #if html5
        start_lvl1();
        #else
        FlxG.camera.fade(FlxColor.BLACK, 0.5, false, start_lvl1);
        #end
    }

    function clickOptions():Void {
        #if html5
        options();
        #else
        FlxG.camera.fade(FlxColor.BLACK, 0.5, false, options);
        #end
    }

    function clickBestiaire():Void {
        #if html5
        bestiary();
        #else
        FlxG.camera.fade(FlxColor.BLACK, 0.5, false, bestiary);
        #end
    }

    function clickBonus():Void {
        #if html5
        bonus();
        #else
        FlxG.camera.fade(FlxColor.BLACK, 0.5, false, bonus);
        #end
    }

    function bonus():Void {
        #if !html5
        FlxG.camera.fade(FlxColor.TRANSPARENT, 0.5, true);
        #end
        FlxG.switchState(new QuizState());
    }

    function start_lvl1():Void {
        #if !html5
        FlxG.camera.fade(FlxColor.TRANSPARENT, 0.5, true);
        #end
        FlxG.switchState(new DifficultyState());
    }

    function options():Void {
        #if !html5
        FlxG.camera.fade(FlxColor.TRANSPARENT, 0.5, true);
        #end
        openSubState(new OptionSubState());
    }

    function bestiary():Void {
        #if !html5
        FlxG.camera.fade(FlxColor.TRANSPARENT, 0.5, true);
        #end
        FlxG.switchState(new BestiaryState());
    }

    function quitter():Void {
        System.exit(0);
    }

    
}