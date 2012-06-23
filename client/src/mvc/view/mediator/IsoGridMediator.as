/**
 * @author baz
 */
package mvc.view.mediator {
import event.UIEvent;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import mvc.model.GridModel;

import org.robotlegs.mvcs.Mediator;

import ui.IsoGrid;

public class IsoGridMediator extends Mediator {

    [Inject]
    public var view:IsoGrid;

    [Inject]
    public var gridModel:GridModel;

    override public function onRegister():void {
        view.buildLayout();

        addViewListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        addViewListener(MouseEvent.MOUSE_UP, onMouseUp);

        addContextListener(UIEvent.UPDATE_MAP, updateMap);
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

    /**
     * Обновить состояние
     */
    private function updateMap(e:Event):void {
        view.update(gridModel.cellMap);
    }
}
}