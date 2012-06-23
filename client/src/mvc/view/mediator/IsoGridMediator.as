/**
 * @author baz
 */
package mvc.view.mediator {
import event.RequestEvent;
import event.UIEvent;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import mvc.model.GridModel;
import mvc.model.RequestProxy;

import org.robotlegs.mvcs.Mediator;

import ui.IsoGrid;

public class IsoGridMediator extends Mediator {

    [Inject]
    public var view:IsoGrid;

    [Inject]
    public var gridModel:GridModel;

    [Inject]
    public var requestProxy:RequestProxy;

    override public function onRegister():void {
        view.buildLayout();

        addViewListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        addViewListener(MouseEvent.MOUSE_UP, onMouseUp);

        addContextListener(UIEvent.UPDATE_MAP, updateMap);
        addContextListener(RequestEvent.PLANT, onPlantPreRequest);
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

    /**
     * Выбираем ячейку для посадки растения
     * @param e
     */
    private function onPlantPreRequest(requestEvent:RequestEvent):void {
        addViewListener(MouseEvent.MOUSE_MOVE, highLiteCell);
        addViewListener(MouseEvent.CLICK, sendRequest);

        function sendRequest(e:MouseEvent):void {
            removeViewListener(MouseEvent.MOUSE_MOVE, highLiteCell);
            removeViewListener(MouseEvent.CLICK, sendRequest);
            requestProxy.sendPlantRequest(requestEvent.plantType, getIsoPoint(e));
        }
    }

    /**
     * Подсветить ячейку
     */
    private function highLiteCell(e:MouseEvent):void {
        var isoPoint:Point = getIsoPoint(e);
        view.selectCell(isoPoint.x, isoPoint.y);
    }

    /**
     * REFACTOR:
     * Найти координаты ячейки
     */
    private function getIsoPoint(e:MouseEvent):Point {
        var gridPoint:Point = view.globalToLocal(new Point(e.stageX, e.stageY));

        const y:Number = gridPoint.y * 2;
        var isoX:int = Math.floor((y + gridPoint.x) / AppSettings.CELL_WIDTH);
        var isoY:int = Math.floor((y - gridPoint.x) / AppSettings.CELL_WIDTH);

        return new Point(isoX, isoY);
    }
}
}