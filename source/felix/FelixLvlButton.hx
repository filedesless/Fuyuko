package felix;

import flixel.text.FlxText;
import flixel.FlxSprite;
import scene.levels.JsonHeader;
import flixel.group.FlxSpriteGroup;

class FelixLvlButton extends FlxSpriteGroup {
    public var lvl:Int;

    public function new (?X:Float, ?Y:Float, header:JsonHeader) {
        super(X, Y);
        lvl = header.lvl;

        scrollFactor.set();
        var thumb = new FlxSprite(0, 0, if (lvl <= felix.FelixSave.get_level_completed()) "assets/tilemap/" + header.thumbnail else AssetPaths.question_mark__png);
        thumb.scale.set(0.04, 0.04);
        thumb.updateHitbox();
        add(thumb);
        var txt = new FlxText(0, thumb.height + 20, 0, header.name, 16);
        if (txt.width <= thumb.width)
            txt.x = (thumb.width - txt.width) / 2;
        
        add(txt);
    }

    override public function update(elapsed:Float):Void {
        
        super.update(elapsed);
    }
}