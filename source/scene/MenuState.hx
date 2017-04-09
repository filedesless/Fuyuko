package scene;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxAxes;

import scene.levels.LvlDemo;

import felix.FelixMagicButton;

import flash.system.System;

/*
    Entry point of the game; main menu
*/
class MenuState extends FlxState
{
    var btnNewGame:FelixMagicButton;
    var btnContinue:FelixMagicButton;
    var btnCinematique:FelixMagicButton;
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

        var bg:FlxSprite = new FlxSprite();
        bg.loadGraphic(AssetPaths.sakuratree__png, true, 500, 281);
        bg.animation.add("def", [for (i in 0...25) i], 10, true);
        bg.animation.play("def");
        bg.setGraphicSize(FlxG.width, FlxG.height);
        bg.updateHitbox();
        add(bg);

        bgColor = FlxColor.TRANSPARENT;

        // starts music
        #if flash
        felix.FelixSound.playBackground(AssetPaths.menu__mp3);
        #else
        felix.FelixSound.playBackground(AssetPaths.menu__ogg);
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
            this, "Options", options
        );

        btnCinematique = new FelixMagicButton(
            FlxG.camera.width / 2 - btnOptions.width - 20,
            FlxG.camera.height * 6 / 10,
            this, "Cinématique", clickPlay
        );

        btnBestiaire = new FelixMagicButton(
            FlxG.camera.width / 2 + 20,
            FlxG.camera.height * 6 / 10,
            this, "Bestiaire", clickPlay
        );

        btnQuitter = new FelixMagicButton(
            null,
            FlxG.camera.height * 8 / 10,
            this, "Quitter", quitter
        );

        add(btnNewGame);
        add(btnContinue);
        add(btnCinematique);
        add(btnBestiaire);
        add(btnOptions);
        add(btnQuitter);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    // starts game in a second
    private function clickPlay():Void {
        FlxG.camera.fade(FlxColor.BLACK, 1, false, start_lvl1);
    }

    private function start_lvl1():Void {
        FlxG.switchState(new LvlDemo());
    }

    private function quitter():Void {
        System.exit(0);
    }

    private function options():Void {
        openSubState(new OptionSubState());
    }
}