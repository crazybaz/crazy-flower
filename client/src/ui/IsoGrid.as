/**
 * @author baz
 */
package ui {
import core.AssetSprite;
import core.ResourceManager;

import flash.display.Sprite;
import flash.utils.Dictionary;

public class IsoGrid extends Sprite {

    private var tileMap:Dictionary;

    public function IsoGrid() {
        tileMap = new Dictionary();
    }

    public function buildLayout():void {
        // Подложка
        var bg:AssetSprite = new AssetSprite(ResourceManager.BG);
        addChild(bg);

        // Собрать и отрисовать карту
        var gridBox:Sprite = new Sprite();
        gridBox.rotation = 45;

        for (var i:int = 0; i < AppSettings.GRID_SIZE; i++) {
            tileMap[i] = new Dictionary();
            for (var j:int = 0; j < AppSettings.GRID_SIZE; j++) {
                var tile:IsoTile = new IsoTile(i, j);
                tileMap[i][j] = tile;
                gridBox.addChild(tile);
            }
        }
        var gridLayer:Sprite = new Sprite();
        gridLayer.scaleY = 0.5;
        gridLayer.addChild(gridBox);
        addChild(gridLayer);
        gridLayer.x = 742;
        gridLayer.y = 97;
    }
}
}
