/**
 * @author baz
 */
package ui {
import core.AssetSprite;
import core.Cell;
import core.ResourceManager;

import flash.display.DisplayObject;
import flash.display.Sprite;

public class PlantTile extends Sprite {
    private var isoX:int;
    private var isoY:int;

    public var image:DisplayObject;

    public function PlantTile(isoX:int, isoY:int):void {
        this.isoX = isoX;
        this.isoY = isoY;
        updateLayout();
    }


    public function updateLayout():void {
        this.x = (isoX - isoY) * AppSettings.CELL_WIDTH / 2;
        this.y = (isoX + isoY) * AppSettings.CELL_WIDTH / 4;
    }

    /**
     * Обновить состояние
     */
    public function update(cell:Cell):void {
        if (cell.hasContent) {
            var plantPath:String = ResourceManager.getPlantPath(cell.plantType, cell.plantLevel);
            var plantView:AssetSprite = new AssetSprite(plantPath, function ():void {
                this.x -= this.width / 2;
                this.y -= this.height - AppSettings.CELL_WIDTH / 2 - 5;
            });
            setView(plantView);

        } else {
            removeView();
        }
    }

    /**
     * Установить растения
     * @param image
     */
    public function setView(image:DisplayObject):void {
        removeView();
        addChild(image);
        this.image = image;
    }

    /**
     * Удалить изображение растения
     */
    public function removeView():void {
        removeChildren();
        image = null;
    }
}
}
