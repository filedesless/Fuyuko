package scene;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxAxes;

import scene.levels.Lvl1;

import felix.FelixMagicButton;

import flash.system.System;

/*
    Entry point of the game; main menu
*/
class MenuState extends FlxState
{
    var btnNewGame:FelixMagicButton;
    var btnContinue:FelixMagicButton;
    var btnBonus:FelixMagicButton;
    var btnOptions:FelixMagicButton;
    var btnBestiaire:FelixMagicButton;
    var btnQuitter:FelixMagicButton;

    override public function create():Void
    {
        super.create();
        persistentDraw = false;
        FlxG.scaleMode = new flixel.system.scaleModes.FillScaleMode();
        FlxG.watch.addMouse();
        FlxG.watch.add(FlxG.save, "data");
        
        #if mac
        if (!felix.FelixSave.get_setup_done()) {
            Sys.command("defaults write -g ApplePressAndHoldEnabled -bool false");
            trace("executed");
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
        #if flash
        felix.FelixSound.playBackground(AssetPaths.menu__mp3);
        #else
        felix.FelixSound.playBackground(AssetPaths.forest__ogg);
        #end

        var logo = new FlxSprite(0, 0, AssetPaths.logo_transparent__png);
        logo.setGraphicSize(600);
        logo.updateHitbox();
        logo.screenCenter(FlxAxes.X);
        logo.y += 30;
        add(logo);

        btnContinue = new FelixMagicButton(
            FlxG.camera.width / 2 + 20,
            FlxG.camera.height * 4 / 10,
            this, "Continuer", clickPlay
        );

        btnNewGame = new FelixMagicButton(
            FlxG.camera.width / 2 - btnContinue.width - 20,
            FlxG.camera.height * 4 / 10,
            this, "Nouvelle partie", clickPlay, 26
        );

        btnOptions = new FelixMagicButton(
            null,
            FlxG.camera.height * 5 / 10,
            this, "Options", clickOptions
        );

        btnBonus = new FelixMagicButton(
            FlxG.camera.width / 2 - btnOptions.width - 20,
            FlxG.camera.height * 6 / 10,
            this, "Bonus"
        );

        btnBestiaire = new FelixMagicButton(
            FlxG.camera.width / 2 + 20,
            FlxG.camera.height * 6 / 10,
            this, "Bestiaire", clickBestiaire
        );
     
        btnQuitter = new FelixMagicButton(
            null,
            FlxG.camera.height * 8 / 10,
            this, "Quitter", quitter
        );
        #if html5
        btnQuitter.disable();
        #end

        if (felix.FelixSave.get_level_completed() <= 0)
            btnContinue.disable();

        add(btnNewGame);
        add(btnContinue);
        add(btnBonus);
        add(btnBestiaire);
        add(btnOptions);
        add(btnQuitter);
    }

    override public function update(elapsed:Float):Void
    {
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

    function start_lvl1():Void {
        #if !html5
        FlxG.camera.fade(FlxColor.TRANSPARENT, 0.5, true);
        #end
        FlxG.switchState(new Lvl1());
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