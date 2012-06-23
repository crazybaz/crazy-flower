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

        this.x = (isoX - isoY) * AppSettings.CELL_SIZE / 2;
        this.y = (isoX + isoY) * AppSettings.CELL_SIZE / 4;

        plantLayer = new Sprite();
        cellLayer = new Sprite();

        addChild(plantLayer);
        addChild(cellLayer);

        plantLayer.x = -AppSettings.CELL_SIZE / 2;
        plantLayer.y = -AppSettings.CELL_SIZE / 2;

        // DEBUG:
        drawCellView();
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
    private function drawCellView():void {
        var rectSize:Number = Math.sqrt(2 * Math.pow(AppSettings.CELL_SIZE / 2, 2));

        var cellView:Shape = new Shape();
        cellView.graphics.lineStyle(1, 0x777777, 0.5);
        cellView.graphics.beginFill(0x777777, 0.15);
        cellView.graphics.drawRect(0, 0, rectSize, rectSize);
        cellView.graphics.endFill();
        cellView.rotation = 45;

        var cellGroup:Sprite = new Sprite();
        cellGroup.addChild(cellView);
        cellGroup.scaleY = 0.5;
        cellLayer.addChild(cellGroup);

        // DEBUG:
        cellGroup.graphics.lineStyle(1, 0xff00ff);
        cellGroup.graphics.moveTo(-5, -5);
        cellGroup.graphics.lineTo(5, 5);
        cellGroup.graphics.moveTo(5, -5);
        cellGroup.graphics.lineTo(-5, 5);
    }
}
}
