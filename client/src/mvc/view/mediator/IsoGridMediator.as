/**
 * @author baz
 */
package mvc.view.mediator {
import core.AssetSprite;
import core.Cell;
import core.ResourceManager;

import event.RequestEvent;
import event.UIEvent;

import flash.display.DisplayObject;
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

        addViewListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        addViewListener(MouseEvent.MOUSE_UP, onMouseUp);
        addViewListener(MouseEvent.MOUSE_MOVE, onMouseMove);

        addContextListener(UIEvent.UPDATE_MAP, updateMap);
        addContextListener(RequestEvent.PLANT, onPlantPreRequest);
        addContextListener(RequestEvent.COLLECT, onCollectPreRequest);
    }

    // Данные для обработки мышки
    private var mousePoint:Point;
    private var mouseIsoPoint:Point;
    private var isMouseMoved:Boolean;
    private var draggedPlantView:DisplayObject;

    private function onMouseDown(e:MouseEvent):void {
        mousePoint = new Point(e.stageX, e.stageY);
        mouseIsoPoint = getIsoPoint(e);

        // Смотрим что в ячейке
        var isoPoint:Point = getIsoPoint(e);
        var cell:Cell = gridModel.getCell(isoPoint.x, isoPoint.y);
        if (cell && cell.hasContent) {
            var plantTile:PlantTile = view.getPlantTile(isoPoint.x, isoPoint.y);
            // Создаём экземпляр для таскания
            draggedPlantView = new AssetSprite(ResourceManager.getPlantPath(cell.plantType, cell.plantLevel));
            view.dragLayer.addChild(draggedPlantView);
            draggedPlantView.x = plantTile.x + plantTile.image.x;
            draggedPlantView.y = plantTile.y + plantTile.image.y;
            // Очистить саму ячейку
            plantTile.removeView();
        }
    }

    private function onMouseUp(e:MouseEvent):void {
        // Клик
        isMouseMoved == false && onMouseClick(e);

        // Таскали растение
        if (draggedPlantView) {
            var newIsoPoint:Point = getIsoPoint(e);
            // Если конечная ячейка существует в гриде и она свободная
            var cell:Cell = gridModel.getCell(newIsoPoint.x, newIsoPoint.y);
            if (cell && cell.hasContent == false) {
                // Изменили позицию
                if (mouseIsoPoint.equals(newIsoPoint) == false) {
                    // Запрос на сервер
                    requestProxy.sendMoveRequest(mouseIsoPoint, newIsoPoint);
                    // Ставим в ячейку изображение
                    var newPlantTile:PlantTile = view.getPlantTile(newIsoPoint.x, newIsoPoint.y);
                    newPlantTile.setView(draggedPlantView);
                } else {
                    revertDragBack();
                }
            } else {
                revertDragBack();
            }
        }

        // Вернуть изображение на место
        function revertDragBack():void {
            var startPlantTile:PlantTile = view.getPlantTile(mouseIsoPoint.x, mouseIsoPoint.y);
            startPlantTile.setView(draggedPlantView);
        }

        mousePoint = null;
        mouseIsoPoint = null;
        isMouseMoved = false;
        draggedPlantView = null;
    }

    /**
     * Обработчик движения мышью
     * @param e
     */
    private function onMouseMove(e:MouseEvent):void {
        // Подсветить ячейку
        var isoPoint:Point = getIsoPoint(e);
        view.selectCell(isoPoint.x, isoPoint.y);

        if (mousePoint) {
            isMouseMoved = true;

            var curPoint:Point = new Point(e.stageX, e.stageY);

            // Перетаскивание растения
            if (draggedPlantView) {
                movePlant(curPoint);
            } else {
                moveIsoGrid(curPoint);
            }
        }
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
     * Таскание карты
     */
    private function moveIsoGrid(curPoint:Point):void {
        view.x += curPoint.x - mousePoint.x;
        view.y += curPoint.y - mousePoint.y;

        // Не даём скролить карту дальше не видимой области
        view.x = Math.min(view.x, 0);
        view.x = Math.max(view.x, view.stage.stageWidth - view.width);
        view.y = Math.min(view.y, 0);
        view.y = Math.max(view.y, view.stage.stageHeight - view.height);

        mousePoint = curPoint;
    }

    /**
     * Таскание растения
     */
    private function movePlant(curPoint:Point):void {
        draggedPlantView.x += curPoint.x - mousePoint.x;
        draggedPlantView.y += curPoint.y - mousePoint.y;
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