package entity;

import flixel.math.FlxPoint;

interface ILightSource {
    public var baseLight:Int;
    public var center:FlxPoint;
    public var health:Float;
    public function getLightRadius():Float;
}