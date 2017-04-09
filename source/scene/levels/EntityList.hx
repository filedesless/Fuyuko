package scene.levels;

typedef Object = {
    var height:Int;
    var id:Int;
    var name:String;
    var rotation: Int;
    var type:String;
    var visible:Bool;
    var width:Int;
    var x:Int;
    var y:Int;
}

typedef EntityList = {
    var objects:Array<Object>;
}