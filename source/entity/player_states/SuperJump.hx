package entity.player_states;

import addons.FlxFSM;
import flixel.system.FlxSound;

class SuperJump extends FlxFSMState<Player>
{
    var count:Int;
    var jumped:Bool;
    var _jumpSound:FlxSound = new FlxSound();

    override public function enter(owner:Player, fsm:FlxFSM<Player>):Void 
    {
        owner.animation.play("jump");
        count = 0;
        jumped = false;
        owner.speedFactor = 0;
        felix.FelixSound.playGeneric(AssetPaths.jump__ogg, 
            _jumpSound, felix.FelixSave.get_sound_effects(), false);
    }
    
    override public function update(elapsed:Float, owner:Player, fsm:FlxFSM<Player>):Void 
    {
        if (!jumped && count++ > 7) {
            owner.velocity.y = -450;
            jumped = true;
            owner.speedFactor = 1;
        }
    }
}