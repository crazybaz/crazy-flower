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
    public var image:DisplayObject;

    public function PlantTile(isoX:int, isoY:int):void {
        this.x = (isoX - isoY) * AppSettings.CELL_WIDTH / 2;
        this.y = (isoX + isoY) * AppSettings.CELL_WIDTH / 4;
    }


    /**
     * Спозиционировать изображение
     */
    public function updateLayout():void {
        if (image) {
            image.x = -image.width / 2;
            image.y = -image.height + AppSettings.CELL_WIDTH / 2 + 5;
        }
    }

    /**
     * Обновить состояние
     */
    public function update(cell:Cell):void {
        if (cell.hasContent) {
            var plantPath:String = ResourceManager.getPlantPath(cell.plantType, cell.plantLevel);
            var plantView:AssetSprite = new AssetSprite(plantPath, updateLayout);
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
        updateLayout();
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
