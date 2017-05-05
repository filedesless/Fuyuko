package scene;

import flixel.util.FlxColor;
import flash.display.BlendMode;
import flixel.group.FlxGroup;
import entity.Player;
import entity.Entity;
import flixel.util.FlxSpriteUtil;
import flixel.FlxSprite;
import flixel.FlxG;

import entity.misc.ILightSource;

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
        var injured:Bool = (_player.health < 50);
        var lineStyle:LineStyle = { 
            color: if (injured) FlxColor.RED else FlxColor.BLUE,
            thickness:  if (injured) _player.getLightRadius() * ((50 - _player.health) / 50) else 0
        };
        
        makeGraphic(FlxG.width, FlxG.height, 0xFE000000, true);
        FlxSpriteUtil.drawCircle(this, 
            _player.getScreenPosition().x + _player.width / 2, 
            _player.getScreenPosition().y + _player.height / 2,
            _player.getLightRadius(), 0xFFD0D0FF, lineStyle
        );
        _entities.forEachAlive(function(entity:Entity):Void {
            if (Std.is(entity, ILightSource)) {
                var lightSource:ILightSource = cast(entity, ILightSource);
                if (entity.isOnScreen()) {
                    var lrad:Float = lightSource.getLightRadius();
                    if (lrad > 0)
                        FlxSpriteUtil.drawCircle(this, 
                            entity.getScreenPosition().x + entity.width / 2,
                            entity.getScreenPosition().y + entity.height / 2, 
                            lrad, 0xFFD0D0FF
                        );
                }
            }
        });

        _cnt++;
        super.update(elapsed);
    }
}