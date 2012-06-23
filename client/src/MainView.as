/**
 * @author baz
 */
package {
import flash.display.Sprite;

import ui.IsoGrid;

public class MainView extends Sprite {

    public function MainView():void {
    }

    public function buildLayout():void {
        // Поляна
        var isoGrid:IsoGrid = new IsoGrid();
        addChild(isoGrid);
    }
}
}
