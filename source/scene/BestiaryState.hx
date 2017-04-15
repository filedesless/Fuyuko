package scene;

import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import felix.FelixMagicButton;
import flixel.util.FlxAxes;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;


class BestiaryState extends FlxState {
    var _group:FlxSpriteGroup = new FlxSpriteGroup();
    var _canvas:FlxSprite = new FlxSprite();
    var _entity:FlxSprite = new FlxSprite();
    var _btnGroup:FlxSpriteGroup = new FlxSpriteGroup();
    var _btnRetour:FelixMagicButton;

    override public function create():Void {
        _btnRetour = new FelixMagicButton(
            25, FlxG.height - 100, this, "Retour", clickQuitter
        );

        buildFuyuko();
        buildUI();

        super.create();
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
    }

    function buildUI():Void {
        add(new FelixMagicButton(
            -50, 150, this, "Fuyuko", buildFuyuko
        ));

        add(new FelixMagicButton(
            -50, 250, this, "Ekunaa", buildEkunaa
        ));

        add(new FelixMagicButton(
            -50, 350, this, "Shokuka", buildShokuka
        ));
    }

    function buildFuyuko():Void {
        _canvas = new FlxSprite(0, 0, AssetPaths.beast_fuyuko__png);
        _entity = new FlxSprite();
        _entity.loadGraphic(AssetPaths.charsheet_fuyuko__png, true, 128, 256);
        _entity.scale.set(0.6, 0.6);
        _entity.updateHitbox();
        _entity.setPosition(165, 110);

        _entity.animation.add("push", [for (i in 30...38) i], 6, true);
        _entity.animation.add("idle", [for (i in 0...10) i], 6, true);
        _entity.animation.add("walk", [for (i in 10...20) i], 12, true);
        _entity.animation.add("run", [for (i in 10...20) i], 24, true);
        _entity.animation.add("jump", [20,21,22,23,24], 8, false);
        _entity.animation.add("fall", [for (i in 0...3) 24-i], 6, false);
        _entity.animation.add("reco", [for (i in 25...30) i], 24, false);
        _entity.animation.add("crouch", [for (i in 0...4) 29-i], 24, false);
        _entity.animation.play("idle");
        _entity.animation.finishCallback = fuyukoAnimFinished;

        _btnGroup.destroy();
        _btnGroup = new FlxSpriteGroup();
        _btnGroup.add(new FelixMagicButton(
            FlxG.width, 0, this, "Idle", function() { _entity.animation.play("idle"); }
        ));
        _btnGroup.add(new FelixMagicButton(
            FlxG.width, 75, this, "Walk", function() { _entity.animation.play("walk"); }
        ));
        _btnGroup.add(new FelixMagicButton(
            FlxG.width, 150, this, "Run", function() { _entity.animation.play("run"); }
        ));
        _btnGroup.add(new FelixMagicButton(
            FlxG.width, 225, this, "Jump", function() { _entity.animation.play("jump"); }
        ));
        _btnGroup.add(new FelixMagicButton(
            FlxG.width, 300, this, "Push", function() { _entity.animation.play("push"); }
        ));
        _btnGroup.add(new FelixMagicButton(
            FlxG.width, 375, this, "Crouch", function() { _entity.animation.play("crouch"); }
        ));

        add(_btnGroup);

        _btnGroup.forEachOfType(FelixMagicButton, function(btn:FelixMagicButton):Void {
            FlxTween.tween(btn, { x: FlxG.width - btn.width + 50 }, 0.5);
        });
        _btnGroup.screenCenter(FlxAxes.Y);

        show();
    }

    function buildEkunaa():Void {
        _canvas = new FlxSprite(0, 0, AssetPaths.beast_ekuna__png);
        _entity = new FlxSprite();
        _entity.loadGraphic(AssetPaths.charsheet_ekunaa__png, true, 320, 256);
        _entity.scale.set(0.5, 0.5);
        _entity.updateHitbox();
        _entity.flipX = true;
        _entity.setPosition(115, 120);

        _entity.animation.add("idle", [for (i in 0...10) i], 8, true);
        _entity.animation.add("walk", [for (i in 10...20) i], 12, true);
        _entity.animation.add("charge", [for (i in 20...30) i], 24, true);
        _entity.animation.play("idle");

        _btnGroup.destroy();
        _btnGroup = new FlxSpriteGroup();
        _btnGroup.add(new FelixMagicButton(
            FlxG.width, 0, this, "Idle", function() { _entity.animation.play("idle"); }
        ));
        _btnGroup.add(new FelixMagicButton(
            FlxG.width, 75, this, "Walk", function() { _entity.animation.play("walk"); }
        ));
        _btnGroup.add(new FelixMagicButton(
            FlxG.width, 150, this, "Charge", function() { _entity.animation.play("charge"); }
        ));

        add(_btnGroup);

        _btnGroup.forEachOfType(FelixMagicButton, function(btn:FelixMagicButton):Void {
            FlxTween.tween(btn, { x: FlxG.width - btn.width + 50 }, 0.5);
        });
        _btnGroup.screenCenter(FlxAxes.Y);

        show();
    }

    function buildShokuka():Void {
        _canvas = new FlxSprite(0, 0, AssetPaths.beast_Shokuka__png);
        _entity = new FlxSprite();
        _entity.loadGraphic(AssetPaths.charsheet_shokuka__png, true, 634, 637);
        _entity.scale.set(0.2, 0.2);
        _entity.updateHitbox();
        _entity.setPosition(135, 110);

        _entity.animation.add("idle", [for (i in 0...10) i], 6, true);
        _entity.animation.play("idle");

        _btnGroup.destroy();
        _btnGroup = new FlxSpriteGroup();

        add(_btnGroup);

        show();
    }

    function show():Void {
        _group.destroy();
        _group = new FlxSpriteGroup();
        _group.add(_canvas);
        _group.add(_entity);
        _group.screenCenter(FlxAxes.XY);

        add(_group);

        _btnRetour.destroy();
        _btnRetour = new FelixMagicButton(
            25, FlxG.height - 100, this, "Retour", clickQuitter
        );
        add(_btnRetour);
    }

    function fuyukoAnimFinished(name:String):Void {
        switch (name) {
            case "jump": _entity.animation.play("fall");
            case "fall": _entity.animation.play("reco");
        }
    }

    function clickQuitter():Void {
        #if html5
        quitter();
        #else
        FlxG.camera.fade(FlxColor.BLACK, 0.5, false, quitter);
        #end
    }

    function quitter():Void {
        #if !html5
        FlxG.camera.fade(FlxColor.TRANSPARENT, 0.5, true);
        #end
        FlxG.switchState(new MenuState());
    }
}