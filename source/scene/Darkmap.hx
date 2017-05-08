package scene;

import entity.misc.CrystalRed;
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
            color: if (injured) FlxColor.RED else FlxColor.TRANSPARENT,
            thickness:  if (injured) _player.getLightRadius() * ((_player.baseHealth / 2 - _player.health) / (_player.baseHealth / 2)) else 0
        };
        
        makeGraphic(FlxG.width, FlxG.height, 0xFE000000, true);
        
        _entities.forEachAlive(function(entity:Entity):Void {
            if (Std.is(entity, ILightSource)) {
                var lightSource:ILightSource = cast(entity, ILightSource);
                if (entity.isOnScreen()) {
                    var lrad:Float = lightSource.getLightRadius();
                    if (lrad > 0)
                        FlxSpriteUtil.drawCircle(this, 
                            entity.getScreenPosition().x + entity.width / 2,
                            entity.getScreenPosition().y + entity.height / 2, 
                            lrad, if (Std.is(entity, CrystalRed)) FlxColor.fromRGB(240, 0, 208, Math.floor(80 * felix.FelixSave.get_brightness())) 
                                else FlxColor.fromRGB(208, 208, 255, Math.floor(120 * felix.FelixSave.get_brightness()))
                        );
                }
            }
        });
        FlxSpriteUtil.drawCircle(this, 
            _player.getScreenPosition().x + _player.width / 2, 
            _player.getScreenPosition().y + _player.height / 2,
            _player.getLightRadius(), FlxColor.fromRGB(208, 208, 208, Math.floor(96 * felix.FelixSave.get_brightness())), lineStyle
        );
        _cnt++;
        super.update(elapsed);
    }
}