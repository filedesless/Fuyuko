package scene;

import flash.display.BlendMode;
import flixel.group.FlxGroup;
import entity.Player;
import entity.Entity;
import flixel.util.FlxSpriteUtil;
import flixel.FlxSprite;
import flixel.FlxG;

import entity.misc.Torch;

class Darkmap extends FlxSprite {
    var _circleFactor:Float = 0;

    var _player:Player;
    var _entities:FlxTypedGroup<Entity>;

    var _cnt:Int = 0;

    public override function new(?X:Float, ?Y:Float, player:Player, entities:FlxTypedGroup<Entity>) {
        super(X,Y);
        
        _player = player;
        _entities = entities;

        scrollFactor.set();
        blend = BlendMode.MULTIPLY;
    }

    override public function update(elapsed:Float):Void {
        var greenLine:LineStyle = { color: 0xFF00FF00, thickness : 10 };
        var blueLine:LineStyle = { color: 0xFF0000FF, thickness : 5 };

        if (_cnt % 2 == 0) {
            makeGraphic(FlxG.width, FlxG.height, 0xFA000000, true);
            FlxSpriteUtil.drawCircle(this, 
                _player.getScreenPosition().x + _player.width / 2, 
                _player.getScreenPosition().y + _player.height / 2,
                _player.getLightRadius(), 0xFFD0D0FF, greenLine, { smoothing : false }
            );
            _entities.forEachOfType(Torch, function(t:Torch):Void {
                if (t.isOnScreen())
                    FlxSpriteUtil.drawCircle(this, 
                        t.getScreenPosition().x + t.width / 2,
                        t.getScreenPosition().y + t.height / 2, 
                        t.getLightRadius(), 0xFFD0D0FF, blueLine, { smoothing: true }
                    );
            });
        }
        

        _cnt++;
        super.update(elapsed);
    }
}