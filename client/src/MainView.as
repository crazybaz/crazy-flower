/**
 * @author baz
 */
package {
import flash.display.DisplayObject;
import flash.display.Sprite;

import mvc.model.ResourceManager;

public class MainView extends Sprite {

    public function MainView():void {
    }

    public function buildLayout(rm:ResourceManager):void {
        rm.getClover(1, function (bitmap:DisplayObject):void {
            addChild(bitmap);
        })
    }
}
}
