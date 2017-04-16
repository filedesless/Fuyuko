package entity.stalagtite_ice_states;

class Conditions
{
    public static function isTriggered(owner:Stalagtite_ice):Bool {
        return owner.triggered;
    }
    public static function isReady(owner:Stalagtite_ice):Bool {
        return owner.ready;
    }
}