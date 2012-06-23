/**
 * @author baz
 */
package ui {
import core.AssetSprite;
import core.Cell;
import core.ResourceManager;

import flash.display.DisplayObject;
import flash.display.Sprite;

public class IsoTile extends Sprite {
    /**
     * Изометрические координаты с установкой которых, сразу происходит позиционирование
     */
    private var _isoX:int;

    public function set isoX(val:int):void {
        _isoX = val;
        this.x = val * AppSettings.CELL_SIZE;
    }

    public function get isoX():int {
        return _isoX;
    }

    private var _isoY:int;

    public function set isoY(val:int):void {
        _isoY = val;
        this.y = val * AppSettings.CELL_SIZE;
    }

    public function get isoY():int {
        return _isoY;
    }

    // Графика текущего состояния растения
    public var plantView:DisplayObject;

    public function IsoTile(isoX:int, isoY:int):void {
        this.isoX = isoX;
        this.isoY = isoY;
        // DEBUG:
        graphics.lineStyle(1, 0x777777, 0.5);
        graphics.beginFill(0x777777, 0.15);
        graphics.drawRect(0, 0, AppSettings.CELL_SIZE, AppSettings.CELL_SIZE);
        graphics.endFill();
    }

    /**
     * Обновить состояние
     */
    public function update(cell:Cell):void {
        if (cell.hasContent) {
            setView(new AssetSprite(ResourceManager.getPlantPath(cell.plantType, cell.plantLevel)));
        } else {
            removeView();
        }
    }

    /**
     * Установить растения
     * @param image
     */
    private function setView(image:DisplayObject):void {
        removeView();
        plantView = image;
        addChild(image);
    }

    /**
     * Удалить растение
     */
    private function removeView():void {
        plantView && contains(plantView) && removeChild(plantView);
        plantView = null;
    }

    override public function toString():String {
        return "[IsoTile isoX=" + isoX + " isoY=" + isoY + "]";
    }
}
}
