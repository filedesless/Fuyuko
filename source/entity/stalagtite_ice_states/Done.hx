package entity.stalagtite_ice_states;

import flixel.FlxObject;
import flixel.FlxG;
import addons.FlxFSM;

class Done extends FlxFSMState<Stalagtite_ice>
{
    override public function enter(owner:Stalagtite_ice, fsm:FlxFSM<Stalagtite_ice>):Void {
        owner.kill();
    }

    override public function update(elapsed:Float, owner:Stalagtite_ice, fsm:FlxFSM<Stalagtite_ice>):Void {
    }

    override public function exit(owner:Stalagtite_ice):Void {
    }

}