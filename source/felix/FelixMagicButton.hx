package felix;

import flixel.system.FlxSound;
import flixel.util.helpers.FlxBounds;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;
import flixel.effects.particles.FlxEmitter;
import flixel.ui.FlxButton;

class FelixMagicButton extends FlxSpriteGroup {
    public var button:FelixButton;
    public var enabled(default, null):Bool = true;
    var _emitter:FlxEmitter;
    var _callback:Void->Void;

    var _oldBtn:FlxButton = new FlxButton(0, 0, "cache");

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
        _emitter.setPosition(
            FlxG.camera.scroll.x + button.x + button.width / 2,
            FlxG.camera.scroll.y + button.y + button.height / 2
        );

        // if (!button.getBoundingBox(FlxG.camera).containsPoint(FlxG.mouse.getPosition())) {
        //     _emitter.kill();
        // }
        
        super.update(elapsed);
    }

    override public function destroy():Void {
        button.destroy();
        _emitter.destroy();
        super.destroy();
    }

    public function disable():Void {
        if (!enabled) return;
        button.statusAnimations = ["pressed", "pressed", "pressed"];
        _oldBtn.onOver.callback = button.onOver.callback;
        button.onOver.callback = function() { };
        _oldBtn.onDown.callback = button.onDown.callback;
        button.onDown.callback = function() { };
        _oldBtn.onUp.callback = button.onUp.callback;
        button.onUp.callback = function() { };
        _oldBtn.onOver.sound = button.onOver.sound;
        button.onOver.sound = new FlxSound();
        _oldBtn.onUp.sound = button.onUp.sound;
        button.onUp.sound = new FlxSound();
        _oldBtn.color = button.color;
        button.color = FlxColor.GRAY;
        if (button.label.borderColor != 0x00000000) 
            _oldBtn.label.borderColor = button.label.borderColor;
        button.label.borderColor = FlxColor.GRAY;
        _oldBtn.label.color = button.label.color;
        button.label.color = FlxColor.BLACK;
        enabled = false;
    }

    public function enable():Void {
        if (enabled) return;
        button.statusAnimations = ["normal", "highlight", "pressed"];
        button.onOver.callback = _oldBtn.onOver.callback;
        button.onDown.callback = _oldBtn.onDown.callback;
        button.onUp.callback = _oldBtn.onUp.callback;
        button.onOver.sound = _oldBtn.onOver.sound;
        button.onUp.sound = _oldBtn.onUp.sound;
        button.color = _oldBtn.color;
        button.label.borderColor = _oldBtn.label.borderColor;
        button.label.color = _oldBtn.label.color;
        enabled = true;
    }
}