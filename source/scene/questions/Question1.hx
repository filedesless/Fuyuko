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
                "Tous les crystaux rouges"
            ], 2, 1
        );
    }
}