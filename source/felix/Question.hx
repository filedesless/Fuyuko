package felix;

class Question {
    public var question:String;
    public var choix:Array<String>;
    public var correctAnswer:Int;
    public var givenAnswer:Int;
}

class Questions {
    public var faciles:List<Question>;
    public var moyennes:List<Question>;
    public var difficiles:List<Question>;
}