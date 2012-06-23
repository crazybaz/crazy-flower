/**
 * @author baz
 */
package {
import flash.display.Sprite;

import ui.ButtonPanel;
import ui.IsoGrid;

public class MainView extends Sprite {

    public function MainView():void {
    }

    public function buildLayout():void {
        // Поляна
        addChild(new IsoGrid());

        // Кнопочное меню
        addChild(new ButtonPanel());
    }
}
}
