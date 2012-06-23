/**
 * @author baz
 */
package ui {
import core.AssetSprite;
import core.Cell;
import core.ResourceManager;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.display.Sprite;

public class IsoTile extends Sprite {
    /**
     * Изометрические координаты
     */
    private var isoX:int;
    private var isoY:int;

    // Слои для графики
    public var plantLayer:DisplayObjectContainer;
    public var cellLayer:DisplayObjectContainer;

    public function IsoTile(isoX:int, isoY:int):void {
        this.isoX = isoX;
        this.isoY = isoY;

        this.x = (isoX - isoY) * AppSettings.CELL_WIDTH / 2;
        this.y = (isoX + isoY) * AppSettings.CELL_WIDTH / 4;

        plantLayer = new Sprite();
        cellLayer = new Sprite();

        addChild(plantLayer);
        addChild(cellLayer);

        cellLayer.scaleY = 0.5;
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
    private function setView(image:DisplayObject):void {
        removeView();
        plantLayer.addChild(image);
    }

    /**
     * Удалить изображение растения
     */
    private function removeView():void {
        plantLayer.removeChildren();
    }

    /**
     * Отрисовать ромбик
     */
    public function drawCellView():void {
        var rectSize:Number = Math.sqrt(2 * Math.pow(AppSettings.CELL_WIDTH / 2, 2));

        var cellView:Shape = new Shape();
        cellView.graphics.lineStyle(1, 0x777777, 0.5);
        cellView.graphics.beginFill(0x777777, 0.15);
        cellView.graphics.drawRect(0, 0, rectSize, rectSize);
        cellView.graphics.endFill();
        cellView.rotation = 45;

        cellLayer.addChild(cellView);

    }

    /**
     * Убрать ромбик
     */
    public function cleanCellView():void {
        cellLayer.removeChildren();
    }
}
}
