/**
 * @author baz
 */
package mvc.view.mediator {
import flash.events.MouseEvent;
import flash.geom.Point;

import mvc.model.GridModel;

import org.robotlegs.mvcs.Mediator;

import ui.IsoGrid;

public class IsoGridMediator extends Mediator {

    [Inject]
    public var view:IsoGrid;

    [Inject]
    public var isoGrid:GridModel;

    override public function onRegister():void {
        view.buildLayout();

        addViewListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        addViewListener(MouseEvent.MOUSE_UP, onMouseUp);
    }

    // Сохраняем координату мыши
    private var mousePoint:Point;

    private function onMouseDown(e:MouseEvent):void {
        mousePoint = new Point(e.stageX, e.stageY);
        addViewListener(MouseEvent.MOUSE_MOVE, moveIsoGrid);
    }

    private function onMouseUp(e:MouseEvent):void {
        removeViewListener(MouseEvent.MOUSE_MOVE, moveIsoGrid);
    }

    /**
     * Таскание
     */
    private function moveIsoGrid(e:MouseEvent):void {
        var curPoint:Point = new Point(e.stageX, e.stageY);
        view.x += curPoint.x - mousePoint.x;
        view.y += curPoint.y - mousePoint.y;
        mousePoint = curPoint;
    }
}
}