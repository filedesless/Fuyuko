package scene;

import flixel.util.FlxColor;
import flixel.math.FlxRect;
import flixel.FlxSubState;
import flixel.FlxG;

import scene.OptionSubState;

import entity.Player;

import felix.FelixMagicButton;

/*
    When the player presses pause
*/
class PauseSubState extends FlxSubState {

    private var _player:Player;
    private var _rect:FlxRect;

    public override function new(player:Player, rect:FlxRect, bgColor = 0xB0000000) {
        _player = player;
        _rect = rect;

        super(bgColor);
    }

    override public function create():Void {
        super.create();

        persistentDraw = false;

        FlxG.mouse.visible = true;

        add(new FelixMagicButton(
            null, FlxG.camera.height / 3,
            this, "Retour", exit
        ));

        add(new FelixMagicButton(
            null, null, 
            this, "Options", options
        ));
        
        add(new FelixMagicButton(
            null, FlxG.camera.height * 2 / 3, 
            this, "Quitter", click_quitter
        ));
    }

    override public function update(elapsed:Float):Void {
        if (FlxG.keys.anyJustPressed([ESCAPE, P])) {
            exit();
        }

        super.update(elapsed);
    }

    function exit():Void {
        FlxG.mouse.visible = false;
        close();
    }

    function click_options():Void {
        FlxG.camera.fade(FlxColor.BLACK, 0.5, false, options);
    }

    function options():Void {
        FlxG.camera.fade(FlxColor.TRANSPARENT, 0.5, true);
        openSubState(new OptionSubState(0xF0000015));
    }

    function click_quitter():Void {
        FlxG.camera.fade(FlxColor.TRANSPARENT, 0.5, false, actuallyQuit);
    }

    function actuallyQuit():Void {
        FlxG.switchState(new MenuState());
    }
}