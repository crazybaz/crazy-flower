/**
 * @author baz
 */
package {
import flash.display.Sprite;

public class MainView extends Sprite {

    public function MainView():void {
    }

    public function buildLayout():void {
        addChild(new MazeMap());
        addChild(new FleaView());
    }
}
}
