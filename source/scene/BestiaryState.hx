package scene;

import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import felix.FelixMagicButton;
import flixel.util.FlxAxes;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import entity.misc.Loading;

class BestiaryState extends FlxState {
    var _groupFuyuko:FlxSpriteGroup;
    var _canvasFuyuko:FlxSprite;
    var _entityFuyuko:FlxSprite;
    var _btnGroupFuyuko:FlxSpriteGroup;

    var _groupEkunaa:FlxSpriteGroup;
    var _canvasEkunaa:FlxSprite;
    var _entityEkunaa:FlxSprite;
    var _btnGroupEkunaa:FlxSpriteGroup;

    var _groupShokuka:FlxSpriteGroup;
    var _canvasShokuka:FlxSprite;
    var _entityShokuka:FlxSprite;

    var _groupSuraimu:FlxSpriteGroup;
    var _canvasSuraimu:FlxSprite;
    var _entitySuraimu:FlxSprite;
    var _btnGroupSuraimu:FlxSpriteGroup;

    var _groups:FlxSpriteGroup = new FlxSpriteGroup();
    var _btnGroups:FlxSpriteGroup = new FlxSpriteGroup();
    var _cnt:Int = 0;

    var _btnRetour:FelixMagicButton;
    var _btnFuyuko:FelixMagicButton;
    var _btnEkunaa:FelixMagicButton;
    var _btnShokuka:FelixMagicButton;
    var _btnSuraimu:FelixMagicButton;
    var _load:Loading;

    override public function create():Void {
        FlxG.camera.fade(FlxColor.TRANSPARENT, 2, true);
        FlxG.camera.antialiasing = felix.FelixSave.get_antialiasing();
        _load = new Loading();
        _load.screenCenter(FlxAxes.XY);
        add(_load);

        super.create();
    }

    override public function update(elapsed:Float):Void {
        if (_cnt <= 75) {
            buildFuyuko();
            buildEkunaa();
            buildShokuka();
            buildSuraimu();
            buildUI();
            _cnt++;
        } else _load.kill();

        super.update(elapsed);
    }

    function buildUI():Void {
        if (_cnt == 67) {
            _groups.add(_btnGroups);
            _btnRetour = new FelixMagicButton(
                25, FlxG.height - 100, this, "Retour", clickQuitter
            );

            add(_groupFuyuko);
            add(_btnGroups);
        }
        
        if (_cnt == 69)
        _btnFuyuko = new FelixMagicButton(
            -50, 150, this, "Fuyuko", showFuyuko
        );

        if (_cnt == 71)
        _btnEkunaa = new FelixMagicButton(
            -50, 225, this, "Ekunaa", showEkunaa
        );

        if (_cnt == 73)
        _btnShokuka = new FelixMagicButton(
            -50, 300, this, "Shokuka", showShokuka
        );

        if (_cnt == 75)
        _btnSuraimu = new FelixMagicButton(
            -50, 375, this, "Suraimu", showSuraimu
        );

        if (_cnt == 75) {
            add(_btnRetour);
            add(_btnFuyuko);
            add(_btnEkunaa);
            add(_btnShokuka);
            add(_btnSuraimu);
            showFuyuko();
        }
    }

    function buildFuyuko():Void {
        if (_cnt == 0) {
            _canvasFuyuko = new FlxSprite(0, 0, AssetPaths.beast_fuyuko__png);
        }
        
        if (_cnt == 5) {
            _entityFuyuko = new FlxSprite();
            _entityFuyuko.loadGraphic(AssetPaths.charsheet_fuyuko__png, true, 128, 256);
            _entityFuyuko.scale.set(0.6, 0.6);
            _entityFuyuko.updateHitbox();
            _entityFuyuko.setPosition(90, 40);
        }
        
        if (_cnt == 10) {
            _entityFuyuko.animation.add("push", [for (i in 30...38) i], 6, true);
            _entityFuyuko.animation.add("idle", [for (i in 0...10) i], 6, true);
            _entityFuyuko.animation.add("walk", [for (i in 10...20) i], 12, true);
            _entityFuyuko.animation.add("run", [for (i in 10...20) i], 24, true);
            _entityFuyuko.animation.add("jump", [20,21,22,23,24], 8, false);
            _entityFuyuko.animation.add("fall", [for (i in 0...3) 24-i], 6, false);
            _entityFuyuko.animation.add("reco", [for (i in 25...30) i], 24, false);
            _entityFuyuko.animation.add("crouch", [for (i in 0...4) 29-i], 24, false);
            _entityFuyuko.animation.play("idle");
            _entityFuyuko.animation.finishCallback = fuyukoAnimFinished;
        }
        
        if (_cnt == 12) {
            _btnGroupFuyuko = new FlxSpriteGroup();
            _btnGroupFuyuko.add(new FelixMagicButton(
                FlxG.width, 0, this, "Idle", function() { _entityFuyuko.animation.play("idle"); }
            ));
            _btnGroupFuyuko.add(new FelixMagicButton(
                FlxG.width, 75, this, "Walk", function() { _entityFuyuko.animation.play("walk"); }
            ));
            _btnGroupFuyuko.add(new FelixMagicButton(
                FlxG.width, 150, this, "Run", function() { _entityFuyuko.animation.play("run"); }
            ));
            _btnGroupFuyuko.add(new FelixMagicButton(
                FlxG.width, 225, this, "Jump", function() { _entityFuyuko.animation.play("jump"); }
            ));
            _btnGroupFuyuko.add(new FelixMagicButton(
                FlxG.width, 300, this, "Push", function() { _entityFuyuko.animation.play("push"); }
            ));
            _btnGroupFuyuko.add(new FelixMagicButton(
                FlxG.width, 375, this, "Crouch", function() { _entityFuyuko.animation.play("crouch"); }
            ));
            _btnGroupFuyuko.screenCenter(FlxAxes.Y);
        }
        
        if (_cnt == 15) {
            _groupFuyuko = new FlxSpriteGroup();
            _groupFuyuko.add(_canvasFuyuko);
            _groupFuyuko.add(_entityFuyuko);
            _groupFuyuko.screenCenter(FlxAxes.X);
            _groupFuyuko.y = 40;

            _btnGroups.add(_btnGroupFuyuko);
            _groups.add(_groupFuyuko);
        }
        
    }

    function showFuyuko():Void {
        _btnGroupEkunaa.forEachOfType(FelixMagicButton, function(btn:FelixMagicButton):Void {
            FlxTween.tween(btn, { x: FlxG.width }, 0.5);
        });
        _btnGroupSuraimu.forEachOfType(FelixMagicButton, function(btn:FelixMagicButton):Void {
            FlxTween.tween(btn, { x: FlxG.width }, 0.5);
        });

        remove(_groupEkunaa);
        remove(_groupShokuka);
        add(_groupFuyuko);
        remove(_groupSuraimu);

        _btnFuyuko.disable();
        _btnEkunaa.enable();
        _btnShokuka.enable();
        _btnSuraimu.enable();

        _btnGroupFuyuko.forEachOfType(FelixMagicButton, function(btn:FelixMagicButton):Void {
            FlxTween.tween(btn, { x: FlxG.width - btn.width + 50 }, 0.5);
        });
    }

    function buildEkunaa():Void {
        if (_cnt == 17) {
            _canvasEkunaa = new FlxSprite(0, 0, AssetPaths.beast_ekuna__png);
        }
        
        if (_cnt == 22) {
            _entityEkunaa = new FlxSprite();
            _entityEkunaa.loadGraphic(AssetPaths.charsheet_ekunaa__png, true, 320, 256);
            _entityEkunaa.scale.set(0.75, 0.75);
            _entityEkunaa.updateHitbox();
            _entityEkunaa.flipX = true;
            _entityEkunaa.setPosition(60, 60);
        }
        
        if (_cnt == 27) {
            _entityEkunaa.animation.add("idle", [for (i in 0...10) i], 8, true);
            _entityEkunaa.animation.add("walk", [for (i in 10...20) i], 12, true);
            _entityEkunaa.animation.add("charge", [for (i in 20...30) i], 24, true);
            _entityEkunaa.animation.play("idle");
        }
        
        if (_cnt == 30) {
            _btnGroupEkunaa = new FlxSpriteGroup();
            _btnGroupEkunaa.add(new FelixMagicButton(
                FlxG.width, 0, this, "Idle", function() { _entityEkunaa.animation.play("idle"); }
            ));
            _btnGroupEkunaa.add(new FelixMagicButton(
                FlxG.width, 75, this, "Walk", function() { _entityEkunaa.animation.play("walk"); }
            ));
            _btnGroupEkunaa.add(new FelixMagicButton(
                FlxG.width, 150, this, "Charge", function() { _entityEkunaa.animation.play("charge"); }
            ));
            _btnGroupEkunaa.screenCenter(FlxAxes.Y);
        }
        
        if (_cnt == 32) {
            _groupEkunaa = new FlxSpriteGroup();
            _groupEkunaa.add(_canvasEkunaa);
            _groupEkunaa.add(_entityEkunaa);
            _groupEkunaa.screenCenter(FlxAxes.X);
            _groupEkunaa.y = 40;

            _btnGroups.add(_btnGroupEkunaa);
            _groups.add(_groupEkunaa);
        }
    }

    function showEkunaa():Void {
        _btnGroupFuyuko.forEachOfType(FelixMagicButton, function(btn:FelixMagicButton):Void {
            FlxTween.tween(btn, { x: FlxG.width }, 0.5);
        });
        _btnGroupSuraimu.forEachOfType(FelixMagicButton, function(btn:FelixMagicButton):Void {
            FlxTween.tween(btn, { x: FlxG.width }, 0.5);
        });

        remove(_groupFuyuko);
        remove(_groupShokuka);
        add(_groupEkunaa);
        remove(_groupSuraimu);

        _btnFuyuko.enable();
        _btnEkunaa.disable();
        _btnShokuka.enable();
        _btnSuraimu.enable();

        _btnGroupEkunaa.forEachOfType(FelixMagicButton, function(btn:FelixMagicButton):Void {
            FlxTween.tween(btn, { x: FlxG.width - btn.width + 50 }, 0.5);
        });
    }

    function buildShokuka():Void {
        if (_cnt == 35) {
            _canvasShokuka = new FlxSprite(0, 0, AssetPaths.beast_shokuka__png);
            _entityShokuka = new FlxSprite();
            _entityShokuka.loadGraphic(AssetPaths.charsheet_shokuka__png, true, 317, 534);
            _entityShokuka.scale.set(0.38, 0.38);
            _entityShokuka.updateHitbox();
            _entityShokuka.setPosition(80, 20);
        }
        
        if (_cnt == 40) {
            _entityShokuka.animation.add("idle", [0,1,2,3,4,5], 8, true);
            _entityShokuka.animation.play("idle");
        }
        
        if (_cnt == 45) {
            _groupShokuka = new FlxSpriteGroup();
            _groupShokuka.add(_canvasShokuka);
            _groupShokuka.add(_entityShokuka);
            _groupShokuka.screenCenter(FlxAxes.X);
            _groupShokuka.y = 40;
            _groups.add(_groupShokuka);
        }
    }

    function showShokuka():Void {
        _btnGroupFuyuko.forEachOfType(FelixMagicButton, function(btn:FelixMagicButton):Void {
            FlxTween.tween(btn, { x: FlxG.width }, 0.5);
        });
        _btnGroupEkunaa.forEachOfType(FelixMagicButton, function(btn:FelixMagicButton):Void {
            FlxTween.tween(btn, { x: FlxG.width }, 0.5);
        });
        _btnGroupSuraimu.forEachOfType(FelixMagicButton, function(btn:FelixMagicButton):Void {
            FlxTween.tween(btn, { x: FlxG.width }, 0.5);
        });

        remove(_groupFuyuko);
        remove(_groupEkunaa);
        add(_groupShokuka);
        remove(_groupSuraimu);

        _btnFuyuko.enable();
        _btnEkunaa.enable();
        _btnShokuka.disable();
        _btnSuraimu.enable();
    }

    function fuyukoAnimFinished(name:String):Void {
        switch (name) {
            case "jump": _entityFuyuko.animation.play("fall");
            case "fall": _entityFuyuko.animation.play("reco");
        }
    }

    function buildSuraimu():Void {
        if (_cnt == 50) {
            _canvasSuraimu = new FlxSprite(0, 0, AssetPaths.beast_suraimu_vert__png);
            _entitySuraimu = new FlxSprite();
            _entitySuraimu.loadGraphic(AssetPaths.charsheet_suraimu_vert_charsheet__png, true, 256, 192);
            _entitySuraimu.scale.set(0.5, 0.5);
            _entitySuraimu.updateHitbox();
            _entitySuraimu.setPosition(100, 50);
        }
        
        if (_cnt == 55) {
            _entitySuraimu.animation.add("idle", [for (i in 7...14) i], 8, true);
            _entitySuraimu.animation.add("walk", [for (i in 28...35) i], 12, true);
            _entitySuraimu.animation.add("jump", [for (i in 22...27) i], 16, false);
            _entitySuraimu.animation.add("bubble", [for (i in 0...7) i], 24, true);
            _entitySuraimu.animation.add("splash", [15,16,17,18,19,35,36,37,38,39,40,41], 8, false);
            _entitySuraimu.animation.play("idle");
        }
        
        if (_cnt == 60) {
            _btnGroupSuraimu = new FlxSpriteGroup();
            _btnGroupSuraimu.add(new FelixMagicButton(
                FlxG.width, 0, this, "Idle", function() { _entitySuraimu.animation.play("idle"); }
            ));
            _btnGroupSuraimu.add(new FelixMagicButton(
                FlxG.width, 75, this, "Marche", function() { _entitySuraimu.animation.play("walk"); }
            ));
            _btnGroupSuraimu.add(new FelixMagicButton(
                FlxG.width, 150, this, "Saut", function() { _entitySuraimu.animation.play("jump"); }
            ));
            _btnGroupSuraimu.add(new FelixMagicButton(
                FlxG.width, 225, this, "Bubble", function() { _entitySuraimu.animation.play("bubble"); }
            ));
            _btnGroupSuraimu.add(new FelixMagicButton(
                FlxG.width, 300, this, "Splash", function() { _entitySuraimu.animation.play("splash"); }
            ));
            _btnGroupSuraimu.screenCenter(FlxAxes.Y);
        }
        
        if (_cnt == 65) {
            _groupSuraimu = new FlxSpriteGroup();
            _groupSuraimu.add(_canvasSuraimu);
            _groupSuraimu.add(_entitySuraimu);
            _groupSuraimu.screenCenter(FlxAxes.X);
            _groupSuraimu.y = 40;

            _btnGroups.add(_btnGroupSuraimu);
            _groups.add(_groupSuraimu);
        }
    }

    function showSuraimu():Void {
        _btnGroupFuyuko.forEachOfType(FelixMagicButton, function(btn:FelixMagicButton):Void {
            FlxTween.tween(btn, { x: FlxG.width }, 0.5);
        });
        _btnGroupEkunaa.forEachOfType(FelixMagicButton, function(btn:FelixMagicButton):Void {
            FlxTween.tween(btn, { x: FlxG.width }, 0.5);
        });

        remove(_groupFuyuko);
        remove(_groupEkunaa);
        remove(_groupShokuka);
        add(_groupSuraimu);

        _btnFuyuko.enable();
        _btnEkunaa.enable();
        _btnShokuka.enable();
        _btnSuraimu.disable();

        _btnGroupSuraimu.forEachOfType(FelixMagicButton, function(btn:FelixMagicButton):Void {
            FlxTween.tween(btn, { x: FlxG.width - btn.width + 50 }, 0.5);
        });
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
        _groups.forEach(function(item:FlxSprite):Void {
            item.destroy();
        }, true);
        FlxG.switchState(new MenuState());
    }
}