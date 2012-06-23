/**
 * @author baz
 */
package core {
import flash.display.DisplayObject;
import flash.display.Sprite;

public class AssetSprite extends Sprite {
    public function AssetSprite(path:String, onComplete:Function = null) {
        ResourceManager.getImage(path, function (image:DisplayObject):void {
            addChild(image);
            onComplete && onComplete();
        });
    }
}
}
