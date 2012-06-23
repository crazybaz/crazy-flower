/**
 * @author baz
 */
package core {
import flash.display.DisplayObject;
import flash.display.Sprite;

public class AssetSprite extends Sprite {
    public function AssetSprite(path:String) {
        ResourceManager.getImage(path, function (image:DisplayObject, onComplete:Function = null):void {
            addChild(image);
            onComplete && onComplete();
        });
    }
}
}
