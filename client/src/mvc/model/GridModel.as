/**
 * @author baz
 */
package mvc.model {
import core.Cell;

import flash.geom.Point;
import flash.utils.Dictionary;

import org.robotlegs.mvcs.Actor;

public class GridModel extends Actor {

    public var cellMap:Dictionary = new Dictionary();

    /**
     * Создаём пустую гриду
     */
    public function GridModel() {
        for (var i:int = 0; i < AppSettings.GRID_SIZE; i++) {
            cellMap[i] = new Dictionary();
            for (var j:int = 0; j < AppSettings.GRID_SIZE; j++) {
                cellMap[i][j] = new Cell(new Point(i, j));
            }
        }
    }

    /**
     * Синхронизируем карту
     */
    public function sync(mapData:Object):void {
        // Пробегаем по данным, что передал сервер
        for each (var cellData:Object in mapData) {
            // Обновить клетку
            getCell(cellData["isoX"], cellData["isoY"]).update(cellData);
        }

        // Пробегаем по ячейкам находим мёртвые души
        for (var i:int = 0; i < AppSettings.GRID_SIZE; i++) {
            for (var j:int = 0; j < AppSettings.GRID_SIZE; j++) {
                var cell:Cell = getCell(i, j);
                // Очистить ячейку если её нет в ответе, а у нас она заполнена
                if (cell.isUpdated == false && cell.hasContent && isEmptyCell(cell)) {
                    cell.cleanup();
                }

            }
        }

        function isEmptyCell(cell:Cell):Boolean {
            for each (var cellData:Object in mapData) {
                if (cellData["isoX"] == cell.isoX && cellData["isoY"] == cell.isoY) {
                    return false;
                }
            }
            return true;
        }
    }

    /**
     * Вернуть ячейку по координатам
     */
    public function getCell(i:int, j:int):Cell {
        var cell:Cell;
        if (cellMap[i]) {
            cell = cellMap[i][j];
        }
        return cell;
    }
}
}
