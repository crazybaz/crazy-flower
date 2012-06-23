/**
 * @author baz
 */
package {
import flash.display.Sprite;

import ui.GridView;

public class MainView extends Sprite {

    public function MainView():void {
    }

    public function buildLayout():void {
        // Поляна
        addChild(new GridView());
    }
}
}
