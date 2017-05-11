package felix;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;
import scene.levels.JsonHeader;
import flixel.group.FlxSpriteGroup;

class FelixLvlButton extends FlxSpriteGroup {
    public var lvl:Int;
    public var bg:FlxSprite;

    public function new (?X:Float, ?Y:Float, header:JsonHeader) {
        super(X, Y);
        lvl = header.lvl;

        scrollFactor.set();

        bg = new FlxSprite();
        bg.makeGraphic(200, 150, FlxColor.GRAY, true);
        add(bg);

        var thumb:FlxSprite;
        if (lvl <= felix.FelixSave.get_level_completed()) {
            thumb = new FlxSprite(0, 20, "assets/tilemap/" + header.thumbnail);
            thumb.setGraphicSize(200);
            thumb.updateHitbox();
        } else {
            thumb = new FlxSprite(0, 20, AssetPaths.question_mark__png); 
            thumb.setGraphicSize(50);
            thumb.updateHitbox();
            thumb.x = (200 - thumb.width) / 2;
        }
        
        add(thumb);
        var txt = new FlxText(0, thumb.height + 30, 180, header.name, 16);
        txt.alignment = "center";
        txt.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);
        txt.x = (200 - txt.width) / 2;
        
        add(txt);
    }

    public function enable():Void {
        bg.makeGraphic(200, 150, FlxColor.GRAY, true);
    }

    public function disable():Void {
        bg.makeGraphic(200, 150, 0xFF292929, true);
    }

    override public function update(elapsed:Float):Void {
        
        super.update(elapsed);
    }
}