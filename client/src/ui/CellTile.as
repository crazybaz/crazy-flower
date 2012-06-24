/**
 * @author baz
 */
package ui {
import flash.display.Shape;
import flash.display.Sprite;

public class CellTile extends Sprite {
    public function CellTile(isoX:int, isoY:int):void {
        this.x = (isoX - isoY) * AppSettings.CELL_WIDTH / 2;
        this.y = (isoX + isoY) * AppSettings.CELL_WIDTH / 4;

        scaleY = 0.5;
    }

    /**
     * Отрисовать ромбик
     */
    public function drawCellView():void {
        var rectSize:Number = Math.sqrt(2 * Math.pow(AppSettings.CELL_WIDTH / 2, 2));

        var cellView:Shape = new Shape();
        cellView.graphics.lineStyle(1, 0xff00ff, 0.3);
        cellView.graphics.beginFill(0xff00ff, 0.15);
        cellView.graphics.drawRect(0, 0, rectSize, rectSize);
        cellView.graphics.endFill();
        cellView.rotation = 45;

        addChild(cellView);
    }

    /**
     * Убрать ромбик
     */
    public function cleanCellView():void {
        removeChildren();
    }
}
}
