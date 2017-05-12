package felix.input;

import flixel.FlxG;

class Lefty implements IFelixController {
    public function new() {

    }

    public function getLeftPressed():Bool {
        return FlxG.keys.pressed.LEFT;
    }
    public function getRightPressed():Bool {
        return FlxG.keys.pressed.RIGHT;
    }
    public function getDownPressed():Bool {
        return FlxG.keys.pressed.DOWN;
    }
    public function getUpPressed():Bool {
        return FlxG.keys.pressed.UP || FlxG.keys.pressed.NUMPADZERO;
    }
    public function getModifierPressed():Bool {
        return FlxG.keys.pressed.CONTROL;
    }
}