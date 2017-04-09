package felix;

import flixel.util.helpers.FlxBounds;
import flixel.util.helpers.FlxRangeBounds;
import flixel.util.FlxAxes;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;
import flixel.effects.particles.FlxEmitter;


class FelixMagicButton extends FlxSpriteGroup {
    var _button:FelixButton;
    var _emitter:FlxEmitter;

    public function new (?X:Float, ?Y:Float, state:FlxState, ?text:Null<String>, ?onClick:Null<Void -> Void>, ?fontSize:Null<Int>) {
        var posX:Float = 0;
        if (X != null) posX = X;
        var posY:Float = 0;
        if (Y != null) posY = Y;

        super(posX, posY);

        scrollFactor.set();

        _button = new FelixButton(0, 0, text, onClick, fontSize);
        width = _button.width;
        height = _button.height;

        if (X == null)
            x = FlxG.width / 2 - _button.width / 2;
        if (Y == null) 
            y = FlxG.height / 2 - _button.height / 2;
        add(_button);

        _emitter = new FlxEmitter(0, 0, 150);
        _emitter.setPosition(
            FlxG.camera.scroll.x + _button.x + _button.width / 2,
            FlxG.camera.scroll.y + _button.y + _button.height / 2
        );
        _emitter.makeParticles(5, 5, FlxColor.CYAN, 150);
        _emitter.launchMode = FlxEmitterMode.CIRCLE;
        state.add(_emitter);

        _button.onOver.callback = function():Void {
            _emitter.start(false, 0.0025);
            _emitter.speed.start = new FlxBounds<Float>(150, 200);
            _emitter.speed.end = new FlxBounds<Float>(1, 5);
        }
        _button.onOut.callback = function():Void {
            _emitter.kill();
        }
    }

}