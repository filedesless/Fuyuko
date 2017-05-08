package scene.levels;

typedef JsonEntity = {
    var name:String;
    var desc:Null<String>;
    var x:Float;
    var y:Float;
    var light:Null<Int>;
    var scale:Float;
    var damage:Float;

    // For use with wisps
    var moveX:Null<Float>;
    var moveY:Null<Float>;

    // For use with crystals
    var health:Null<Float>;
}

/**
 *  possible names:
 *  
 *  Player: 200,
 *  IcePlatform: 0,
 *  Stalagmite: 0,
 *  Stalagtite: 0,
 *  CrystalBlue: 128,
 *  Ekunaa: 0,
 *  LightBall: 128,
 *  Shokuka: 128,
 *  Platform: 0,
 */
