package scene;

import flixel.util.FlxColor;
import flixel.FlxSubState;
import flixel.FlxG;

import scene.OptionSubState;

import felix.FelixMagicButton;

/*
    When the player presses pause
*/
class PauseSubState extends FlxSubState {

    var _lvl:Int = 1;

    public override function new(lvl:Int = 1, bgColor = 0xB0000000) {
        _lvl = lvl;
        super(bgColor);
    }

    override public function create():Void {
        super.create();
        FlxG.camera.antialiasing = felix.FelixSave.get_antialiasing();

        persistentDraw = false;

        add(new FelixMagicButton(
            null, FlxG.camera.height / 4,
            this, "Retour", exit
        ));

        add(new FelixMagicButton(
            null, FlxG.camera.height * 3 / 8,  
            this, "Options", options
        ));
        
        add(new FelixMagicButton(
            null, FlxG.camera.height * 5 / 8,  
            this, "Recommencer", click_restart
        ));

        add(new FelixMagicButton(
            null, FlxG.camera.height * 3 / 4, 
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
        close();
    }

    function click_options():Void {
        FlxG.camera.fade(FlxColor.BLACK, 0.5, false, options);
    }

    function options():Void {
        FlxG.camera.fade(FlxColor.TRANSPARENT, 0.5, true);
        openSubState(new OptionSubState(0xF0000015, false));
    }

    function click_restart():Void {
        FlxG.camera.fade(FlxColor.BLACK, 0.5, false, restart);
    }

    function restart():Void {
        FlxG.switchState(new ParentState(_lvl));
    }

    function click_quitter():Void {
        felix.FelixSound.closeSounds();
        FlxG.camera.fade(FlxColor.TRANSPARENT, 0.5, false, actuallyQuit);
    }

    function actuallyQuit():Void {
        FlxG.switchState(new MenuState());
    }
}