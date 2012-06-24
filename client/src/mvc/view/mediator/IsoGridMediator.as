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

import request.CollectRequest;
import request.IRequest;
import request.PlantRequest;

import ui.IsoGrid;
import ui.PlantTile;

public class IsoGridMediator extends Mediator {

    [Inject]
    public var view:IsoGrid;

    [Inject]
    public var gridModel:GridModel;

    [Inject]
    public var requestProxy:RequestProxy;

    // Реквест
    private var request:IRequest;

    override public function onRegister():void {
        view.buildLayout();

        //addViewListener(MouseEvent.CLICK, onMouseClick);
        addViewListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        addViewListener(MouseEvent.MOUSE_UP, onMouseUp);
        addViewListener(MouseEvent.MOUSE_MOVE, onMouseMove);

        addContextListener(UIEvent.UPDATE_MAP, updateMap);
        addContextListener(RequestEvent.PLANT, onPlantPreRequest);
        addContextListener(RequestEvent.COLLECT, onCollectPreRequest);
    }

    // Сохраняем координату мыши
    private var mousePoint:Point;
    private var isMouseMoved:Boolean;

    private function onMouseDown(e:MouseEvent):void {
        mousePoint = new Point(e.stageX, e.stageY);
    }

    private function onMouseUp(e:MouseEvent):void {
        mousePoint = null;
        // Клик
        isMouseMoved == false && onMouseClick(e);
        isMouseMoved = false;
    }

    /**
     * Обработчик движения мышью
     * @param e
     */
    private function onMouseMove(e:MouseEvent):void {
        if (mousePoint) {
            // Таскаем карту
            isMouseMoved = true;
            moveIsoGrid(new Point(e.stageX, e.stageY));
        }

        // Подсветить ячейку
        var isoPoint:Point = getIsoPoint(e);
        view.selectCell(isoPoint.x, isoPoint.y);
    }

    private function onMouseClick(e:MouseEvent):void {
        var isoPoint:Point = getIsoPoint(e);
        var tile:PlantTile = view.getPlantTile(isoPoint.x, isoPoint.y);

        // Послать запрос
        if (tile && request) {
            // REFACTOR:
            // Обновить координаты
            request["isoX"] = isoPoint.x;
            request["isoY"] = isoPoint.y;
            requestProxy.sendRequest(request);
        }
    }

    /**
     * Таскание
     */
    private function moveIsoGrid(curPoint:Point):void {
        view.x += curPoint.x - mousePoint.x;
        view.y += curPoint.y - mousePoint.y;

        // Не даём скролить карту дальше не видимой области
        view.x = Math.min(view.x, 0);
        view.x = Math.max(view.x, view.stage.stageWidth - view.width);
        view.y = Math.min(view.y, 0);
        view.y = Math.max(view.y, view.stage.stageHeight - view.height);
        trace(view.x, view.y)

        mousePoint = curPoint;
    }

    /**
     * Обновить состояние
     */
    private function updateMap(e:Event):void {
        view.update(gridModel.cellMap);
    }

    /**
     * Создаём запрос для выполнения
     * @param e
     */
    private function onPlantPreRequest(e:RequestEvent):void {
        var req:PlantRequest = new PlantRequest();
        req.plantType = e.plantType;
        request = req;
    }

    /**
     * Создаём запрос для выполнения
     * @param e
     */
    private function onCollectPreRequest(e:RequestEvent):void {
        request = new CollectRequest();
    }

    /**
     * Найти координаты ячейки
     */
    private function getIsoPoint(e:MouseEvent):Point {
        var gridPoint:Point = view.plantLayer.globalToLocal(new Point(e.stageX, e.stageY));

        const y:Number = gridPoint.y * 2;
        var isoX:int = Math.floor((y + gridPoint.x) / AppSettings.CELL_WIDTH);
        var isoY:int = Math.floor((y - gridPoint.x) / AppSettings.CELL_WIDTH);

        return new Point(isoX, isoY);
    }
}
}