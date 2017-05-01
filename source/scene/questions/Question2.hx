package scene.questions;

import felix.FelixQuestion;

class Question2 extends FelixQuestion {
    public override function new() {
        super(
            "Quelle couleur est la lumière que Fuyuko récolte?",
            [
                "Jaune",
                "Rouge",
                "Vert",
                "Bleu"
            ], 0, 1
        );
    }
}