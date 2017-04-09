package scene.levels;

import scene.ParentState;

class Lvl0 extends ParentState {
    override public function create() {
        super.create();
        loadMap()
    }
}