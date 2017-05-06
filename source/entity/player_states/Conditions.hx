package entity.player_states;

import flixel.effects.FlxFlicker;
import flixel.FlxObject;
import flixel.FlxG;

class Conditions
{
    public static function isIdle(owner:Player):Bool {
        return !FlxG.keys.anyPressed([A, S, D, W]);
    }
    public static function isWalking(owner:Player):Bool {
        return FlxG.keys.anyPressed([A, D]);
    }
    public static function isRunning(owner:Player):Bool {
        return FlxG.keys.pressed.SHIFT && isWalking(owner);
    }
    public static function isNotRunning(owner:Player):Bool {
        return !isRunning(owner);
    }
    public static function isNotWalking(owner:Player):Bool {
        return !isWalking(owner);
    }
    public static function runToIdle(owner:Player):Bool {
        return isNotWalking(owner) || isNotRunning(owner);
    }
    public static function runToWalk(owner:Player):Bool {
        return isWalking(owner) && isNotRunning(owner);
    }
    public static function isCrouching(owner:Player):Bool {
        return FlxG.keys.pressed.S;
    }
    public static function isNotCrouching(owner:Player):Bool {
        return !isCrouching(owner);
    }
    public static function isJumping(owner:Player):Bool {
        return FlxG.keys.anyPressed([SPACE, W]) && isGrounded(owner) && !owner.cantJump;
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
        return (FlxG.keys.pressed.A && owner.isTouching(FlxObject.LEFT)) ||
            (FlxG.keys.pressed.D && owner.isTouching(FlxObject.RIGHT));
    }
    public static function isNotPushing(owner:Player):Bool {
        return !isPushing(owner);
    }
    public static function isShooting(owner:Player):Bool {
        return FlxG.mouse.justReleased && owner.health > 20 && !FlxFlicker.isFlickering(owner);
    }
}