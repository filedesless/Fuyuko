package felix.input;

import flixel.FlxG;

class Righty implements IFelixController {
    public function new() {

    }
    
    public function getLeftPressed():Bool {
        return FlxG.keys.pressed.A;
    }
    public function getRightPressed():Bool {
        return FlxG.keys.pressed.D;
    }
    public function getDownPressed():Bool {
        return FlxG.keys.pressed.S;
    }
    public function getUpPressed():Bool {
        return FlxG.keys.pressed.W || FlxG.keys.pressed.SPACE;
    }
    public function getModifierPressed():Bool {
        return FlxG.keys.pressed.SHIFT;
    }
}