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
    public function sync(mapData:Object) {
        for (var i:int = 0; i < AppSettings.GRID_SIZE; i++) {
            for (var j:int = 0; j < AppSettings.GRID_SIZE; j++) {
                // Обновить клетку
                Cell(cellMap[i][j]).update(mapData[i][j]);
            }
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
