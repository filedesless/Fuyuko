package scene.questions;

import felix.FelixQuestion;

class Question1 extends FelixQuestion {
    public override function new() {
        super(
            "Quel est le Suraimu original?",
            [
                "Rouge",
                "Bleu",
                "Vert",
                "Peachpuff"
            ], 2, 1
        );
    }
}