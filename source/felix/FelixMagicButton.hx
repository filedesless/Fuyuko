package felix;

import flixel.system.FlxSound;
import flixel.util.helpers.FlxBounds;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;
import flixel.effects.particles.FlxEmitter;


class FelixMagicButton extends FlxSpriteGroup {
    public var button:FelixButton;
    var _emitter:FlxEmitter;
    var _callback:Void->Void;

    var _disabled:Bool = false;
    var _disabledTime:Float = 0;
    var _cnt:Float = 0;

    public function new (?X:Float, ?Y:Float, state:FlxState, ?text:Null<String>, ?onClick:Null<Void -> Void>, ?fontSize:Null<Int>) {
        var posX:Float = 0;
        if (X != null) posX = X;
        var posY:Float = 0;
        if (Y != null) posY = Y;

        super(posX, posY);

        scrollFactor.set();

        button = new FelixButton(0, 0, text, onClick, fontSize);
        width = button.width;
        height = button.height;

        if (X == null)
            x = FlxG.width / 2 - button.width / 2;
        if (Y == null) 
            y = FlxG.height / 2 - button.height / 2;
        add(button);

        _emitter = new FlxEmitter(0, 0, 150);
        _emitter.setPosition(
            FlxG.camera.scroll.x + button.x + button.width / 2,
            FlxG.camera.scroll.y + button.y + button.height / 2
        );
        _emitter.makeParticles(5, 5, FlxColor.CYAN, 150);
        _emitter.launchMode = FlxEmitterMode.CIRCLE;
        state.add(_emitter);

        button.onOver.callback = function():Void {
            _emitter.start(false, 0.0025);
            _emitter.speed.start = new FlxBounds<Float>(150, 200);
            _emitter.speed.end = new FlxBounds<Float>(1, 5);
        }
        button.onOut.callback = function():Void {
            _emitter.kill();
        }
    }

    override public function update(elapsed:Float):Void {
        _emitter.setPosition(button.getMidpoint().x, button.getMidpoint().y);

        if (!button.getBoundingBox(FlxG.camera).containsPoint(FlxG.mouse.getPosition())) {
            _emitter.kill();
        }
        
        super.update(elapsed);
    }

    override public function destroy():Void {
        button.destroy();
        _emitter.destroy();
        super.destroy();
    }

    public function disable():Void {
        button.statusAnimations = ["pressed", "pressed", "pressed"];
        button.onOver.callback = function() { };
        button.onDown.callback = function() { };
        button.onUp.callback = function() { };
        button.onOver.sound = new FlxSound();
        button.onUp.sound = new FlxSound();
        button.color = FlxColor.GRAY;
        button.label.borderColor = FlxColor.GRAY;
        button.label.color = FlxColor.BLACK;
    }
}