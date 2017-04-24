package entity.misc;

import flixel.math.FlxPoint;

interface ICollectableLight extends ILightSource {
    public var center:FlxPoint;
    public var health:Float;
}