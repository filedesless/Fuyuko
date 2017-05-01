package scene.questions;

import felix.FelixQuestion;

class Question3 extends FelixQuestion {
    public override function new() {
        super(
            "Pourquoi le Shokuka dévore la lumière rouge?",
            [
                "Pour se nourrir",
                "Pour la purifier",
                "Pour nuire à Fuyuko",
                "Pour nourrir son maitre"
            ], 1, 1
        );
    }
}