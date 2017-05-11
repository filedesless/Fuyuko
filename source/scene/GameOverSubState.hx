package scene;

import flixel.tweens.FlxTween;
import flixel.util.FlxAxes;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxSubState;
import flixel.FlxG;

import scene.OptionSubState;

import felix.FelixMagicButton;

/*
    When the player dies
*/
class GameOverSubState extends FlxSubState {
    var _lvl:Int = 1;

    public override function new(lvl:Int = 1, bgColor = 0x20300010) {
        _lvl = lvl;
        super(bgColor);
    }

    override public function create():Void {
        super.create();
        FlxG.camera.antialiasing = felix.FelixSave.get_antialiasing();

        persistentDraw = false;

        var title:FlxText = new FlxText(0, 0, 0,'Vous êtes mort!', 66);
        title.screenCenter(FlxAxes.X);
        title.y = 40;
        title.scrollFactor.set();
        title.setBorderStyle(OUTLINE, FlxColor.RED, 5);
        title.alpha = 0;
        FlxTween.tween(title, { alpha: 1 }, 2);
        add(title);

        var sub:FlxText = new FlxText(0, 0, 0,'(${felix.FelixSave.get_deathCount()} fois)', 48);
        sub.screenCenter(FlxAxes.X);
        sub.y = title.height + 40 + 20;
        sub.scrollFactor.set();
        sub.setBorderStyle(OUTLINE, FlxColor.BLUE, 2);
        sub.alpha = 0;
        FlxTween.tween(sub, { alpha: 1 }, 2, { startDelay: 1 });
        add(sub);
        
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
        super.update(elapsed);
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