package felix;

class FelixQuestion {
    public var question:String;
    public var choix:Array<String>;
    public var reponse:Int;
    public var correct:Bool;
    public var niveau:Int;

    public function new(question:String, choix:Array<String>, reponse:Int, niveau:Int) {
        this.question = question;
        this.choix = choix;
        this.reponse = reponse;
        this.niveau = niveau;
    }
}