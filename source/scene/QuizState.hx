package scene;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.util.FlxAxes;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import felix.FelixMagicButton;
import flixel.text.FlxText;
import felix.FelixMusicScroller;

class QuizState extends FlxState {
    var _questions:Array<felix.Question> = new Array<felix.Question>();
    var _currentQuestion:Int = -1;
    var _group:FlxSpriteGroup = new FlxSpriteGroup();
    var music:FelixMusicScroller = new FelixMusicScroller(FlxG.width - 150, 20);
    var _lvl:Int = 0;

    var btnFacile:FelixMagicButton;
    var btnMoyen:FelixMagicButton;
    var btnDiff:FelixMagicButton;
    var title:FlxText;

    override public function create():Void {
        FlxG.camera.antialiasing = felix.FelixSave.get_antialiasing();
        add(new FelixMagicButton(
            FlxG.width - 320, FlxG.height - 120,
            this, "Retour", click_quitter
        ));
        add(music);

        title = new FlxText(0, 40, 0, "Veuillez choisir un niveau de difficulté", 28);
        title.font = AssetPaths.FantasqueSansMono_Regular__ttf;
        title.screenCenter(FlxAxes.X);
        add(title);

        btnFacile = new FelixMagicButton(
            0, title.y + 100,
            this, "Facile", function() { _lvl = 0; clean(); start(); }
        );
        btnFacile.screenCenter(FlxAxes.X);
        add(btnFacile);

        btnMoyen = new FelixMagicButton(
            0, title.y + 200,
            this, "Moyen", function() { _lvl = 1; clean(); start(); }
        );
        btnMoyen.screenCenter(FlxAxes.X);
        add(btnMoyen);

        btnDiff = new FelixMagicButton(
            0, title.y + 300,
            this, "Difficile", function() { _lvl = 2; clean(); start(); }
        );
        btnDiff.screenCenter(FlxAxes.X);
        add(btnDiff);
    }

    function clean() {
        remove(btnFacile);
        btnFacile.kill();
        remove(btnMoyen);
        btnMoyen.kill();
        remove(btnDiff);
        btnDiff.kill();
        remove(title);
    }
    
    function start():Void {
        var questions:felix.Questions = haxe.Json.parse(openfl.Assets.getText(AssetPaths.Question__json));
        for (question in switch (_lvl) {
            case 1: questions.moyennes;
            case 2: questions.difficiles;
            case _: questions.faciles;
        })
            _questions.push(question);

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
                btn.button.scale.set(6, 3);
                btn.button.updateHitbox();
                btn.button.label = new FlxText(0, 0, 0, choix, 20);
                btn.button.label.font = AssetPaths.FantasqueSansMono_Regular__ttf;
                btn.button.label.borderSize = 0;
                btn.button.label.color = FlxColor.BLACK;
                btn.button.labelOffsets[0].x = btn.button.width / 2 - btn.button.label.width / 2;
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

        var msg = new FlxText(0, 0, 0, "Quiz terminé! Voici vos résultats: ", 24);
        msg.font = AssetPaths.FantasqueSansMono_Regular__ttf;
        msg.y = 20;
        msg.x = 20;
        msg.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);
        add(msg);

        var score:Int = 0, total:Int = _questions.length, i:Int = 0;
        for (question in _questions) {
            var bonneReponse:Bool = question.givenAnswer == question.correctAnswer;
            if (question.givenAnswer == question.correctAnswer) ++score;
            var msg = new FlxText(0, 0, 0, question.question + ": ", 18);
            msg.font = AssetPaths.FantasqueSansMono_Regular__ttf;
            msg.y = 80 + i++ * 60;
            msg.x = 70;
            var resp = new FlxText(0, 0, 0, question.choix[question.givenAnswer], 18);
            resp.font = AssetPaths.FantasqueSansMono_Regular__ttf;
            resp.y = msg.y;
            resp.x = msg.x + msg.width;
            resp.color = if (bonneReponse) FlxColor.GREEN else FlxColor.RED;
            var feedback = new FlxText(0, 0, 0, if (bonneReponse) "Bonne réponse! :)" else question.choix[question.correctAnswer] , 18);
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