package entity.player_states;

import flixel.FlxObject;
import flixel.FlxG;

class Conditions
{
    public static function isIdle(owner:Player):Bool {
        return !FlxG.keys.anyPressed([LEFT, RIGHT, UP, DOWN]);
    }
    public static function isWalking(owner:Player):Bool {
        return FlxG.keys.anyPressed([LEFT, RIGHT]);
    }
    public static function isNotWalking(owner:Player):Bool {
        return !isWalking(owner);
    }
    public static function isCrouching(owner:Player):Bool {
        return FlxG.keys.anyPressed([DOWN]);
    }
    public static function isNotCrouching(owner:Player):Bool {
        return !isCrouching(owner);
    }
    public static function isJumping(owner:Player):Bool {
        return FlxG.keys.anyPressed([UP, SPACE]);
    }
    public static function isFalling(owner:Player):Bool {
        return (owner.velocity.y >= 20);
    }
    public static function isFallingAfterJump(owner:Player):Bool {
        return (owner.velocity.y >= 0 && owner.animation.finished);
    }
    public static function isGrounded(owner:Player):Bool {
        return owner.isTouching(FlxObject.DOWN);
    }
    public static function isDone(owner:Player):Bool {
        return owner.animation.finished;
    }
    public static function isPushing(owner:Player):Bool {
        return (FlxG.keys.anyPressed([LEFT]) && owner.isTouching(FlxObject.LEFT)) ||
            (FlxG.keys.anyPressed([RIGHT]) && owner.isTouching(FlxObject.RIGHT));
    }
    public static function isNotPushing(owner:Player):Bool {
        return !isPushing(owner);
    }
}