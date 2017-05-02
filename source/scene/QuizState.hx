package scene;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.util.FlxAxes;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import felix.FelixQuestion;
import felix.FelixMagicButton;
import flixel.text.FlxText;
import scene.questions.*;

class QuizState extends FlxState {
    var _questions:Array<FelixQuestion> = [
        new Question1(), new Question2(), new Question3()
    ];
    var _currentQuestion:Int = -1;
    var _group:FlxSpriteGroup = new FlxSpriteGroup();

    override public function create():Void {
        add(new FelixMagicButton(
            FlxG.width - 320, FlxG.height - 120,
            this, "Retour", click_quitter
        ));
        nextQuestion();
    }

    function nextQuestion():Void {
        remove(_group);
        for (item in _group) item.kill();
        _group.kill();
        _group = new FlxSpriteGroup();

        _currentQuestion++;

        if (_currentQuestion < _questions.length) {
            var question = new FlxText(0, 0, 0, _questions[_currentQuestion].question, 24);
            question.font = AssetPaths.FantasqueSansMono_Regular__ttf;
            var i:Int = 0;
            for (choix in _questions[_currentQuestion].choix) {
                var btn = new FelixMagicButton(0, i++ * 100 + 80, this, choix, function() {
                    _questions[_currentQuestion].givenAnswer = i -1;
                    nextQuestion();
                }, 16);
                btn.button.label.borderSize = 0;
                btn.button.label.color = FlxColor.BLACK;
                _group.add(btn);
            }
            _group.add(question);
            for (element in _group) element.screenCenter(FlxAxes.X);
            _group.y = 150;
            add(_group);
        } else {
            finish();
        }
    }

    function finish():Void {
        remove(_group);
        for (item in _group) item.kill();
        _group.kill();

        var msg = new FlxText(0, 0, 0, "Quiz terminé! Voici vos résultats: ", 28);
        msg.font = AssetPaths.FantasqueSansMono_Regular__ttf;
        msg.y = 20;
        msg.x = 20;
        msg.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);
        add(msg);

        var score:Int = 0, total:Int = _questions.length, i:Int = 0;
        for (question in _questions) {
            var bonneReponse:Bool = question.givenAnswer == question.reponse;
            if (question.givenAnswer == question.reponse) ++score;
            var msg = new FlxText(0, 0, 0, question.question + ": ", 22);
            msg.font = AssetPaths.FantasqueSansMono_Regular__ttf;
            msg.y = 80 + i++ * 60;
            msg.x = 70;
            var resp = new FlxText(0, 0, 0, question.choix[question.givenAnswer], 22);
            resp.font = AssetPaths.FantasqueSansMono_Regular__ttf;
            resp.y = msg.y;
            resp.x = msg.x + msg.width;
            resp.color = if (bonneReponse) FlxColor.GREEN else FlxColor.RED;
            var feedback = new FlxText(0, 0, 0, if (bonneReponse) "Bonne réponse! :)" else question.choix[question.reponse] , 22);
            feedback.font = AssetPaths.FantasqueSansMono_Regular__ttf;
            feedback.y = resp.y + 25;
            feedback.x = msg.x + 50;
            feedback.color = if (bonneReponse) FlxColor.GREEN else 0x00add8e6;
            add(msg);
            add(resp);
            add(feedback);
        }
        msg.text += score + " / " + total;
    }

    function click_quitter():Void {
        FlxG.camera.fade(FlxColor.TRANSPARENT, 0.5, false, actuallyQuit);
    }

    function actuallyQuit():Void {
        FlxG.switchState(new MenuState());
    }
}