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
import ui.IsoTile;

public class IsoGridMediator extends Mediator {

    [Inject]
    public var view:IsoGrid;

    [Inject]
    public var gridModel:GridModel;

    [Inject]
    public var requestProxy:RequestProxy;

    // Реквест
    private var request:IRequest;

    // Координата клетки под курсором


    override public function onRegister():void {
        view.buildLayout();

        addViewListener(MouseEvent.CLICK, onMouseClick);
        addViewListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        addViewListener(MouseEvent.MOUSE_UP, onMouseUp);
        addViewListener(MouseEvent.MOUSE_MOVE, highLiteCell);

        addContextListener(UIEvent.UPDATE_MAP, updateMap);
        addContextListener(RequestEvent.PLANT, onPlantPreRequest);
        addContextListener(RequestEvent.COLLECT, onCollectPreRequest);
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

    private function onMouseClick(e:MouseEvent):void {
        // Завершить подсветку ячеек под мышкой
        //removeViewListener(MouseEvent.MOUSE_MOVE, highLiteCell);

        var isoPoint:Point = getIsoPoint(e);
        var tile:IsoTile = view.getTile(isoPoint.x, isoPoint.y);

        if (tile) {
            // Убрать выделение с ячейки
            tile.cleanCellView();

            // Послать запрос
            if (request) {
                // Обновить координаты
                request["isoX"] = isoPoint.x;
                request["isoY"] = isoPoint.y;
                requestProxy.sendRequest(request);
            }
        }
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
     * Подсветить ячейку
     */
    private function highLiteCell(e:MouseEvent):void {
        var isoPoint:Point = getIsoPoint(e);
        view.selectCell(isoPoint.x, isoPoint.y);

    }

    /**
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