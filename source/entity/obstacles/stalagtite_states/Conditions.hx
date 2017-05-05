package entity.obstacles.stalagtite_states;

class Conditions
{
    public static function isTriggered(owner:Stalagtite):Bool {
        return owner.triggered;
    }
    public static function isReady(owner:Stalagtite):Bool {
        return owner.ready;
    }
}