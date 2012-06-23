/**
 * @author baz
 */
package ui {
import core.AssetSprite;
import core.ResourceManager;

import flash.display.Sprite;

public class GridView extends Sprite {

    public function GridView() {
    }

    public function buildLayout():void {
        // Подложка
        var bg:AssetSprite = new AssetSprite(ResourceManager.BG);
        addChild(bg);
    }
}
}
