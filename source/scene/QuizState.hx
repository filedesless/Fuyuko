package scene;

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
        nextQuestion();
    }

    function nextQuestion():Void {
        _currentQuestion++;
        for (element in _group)
            element.kill();
        var question = new FlxText(
            0, 0, 0, _questions[_currentQuestion].question, 24
        );
        question.font = AssetPaths.FantasqueSansMono_Regular__ttf;
        var i:Int = 0;
        for (choix in _questions[_currentQuestion].choix) {
            var btn = new FelixMagicButton(0, i++ * 100 + 80, this, choix, nextQuestion, 16);
            btn.button.label.borderSize = 0;
            btn.button.label.color = FlxColor.BLACK;
            _group.add(btn);
        }
        _group.add(question);
        for (element in _group) element.screenCenter(FlxAxes.X);
        _group.y = 150;
        add(_group);
    }
}