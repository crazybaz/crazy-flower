/**
 * @author baz
 */
package core {
import flash.display.DisplayObject;
import flash.display.Sprite;

public class AssetSprite extends Sprite {

    private var callBack:Function;

    public function AssetSprite(path:String, callBack:Function = null) {
        this.callBack = callBack;
        ResourceManager.getImage(path, onAssetData);
    }

    public function onAssetData(image:DisplayObject):void {
        addChild(image);
        callBack && callBack();
    }
}
}
