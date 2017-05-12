package felix.input;

interface IFelixController {
    public function getLeftPressed():Bool;
    public function getRightPressed():Bool;
    public function getDownPressed():Bool;
    public function getUpPressed():Bool;
    public function getModifierPressed():Bool;
}