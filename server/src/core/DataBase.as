/**
 * @author baz
 */
package core {
import com.adobe.serialization.json.JSON;

import flash.geom.Point;
import flash.net.SharedObject;

public class DataBase {
    // Актуальная карта
    private var map:Object = {};

    // Локальное хранилище
    private var so:SharedObject;

    public function DataBase(client:String) {
        // Читаем из хранилища
        so = SharedObject.getLocal(client);
        if (so.data.map == null) {
            // Создать пустую бд
            map = getEmptyMap();
            so.data.map = map;
            so.flush();
        } else {
            map = getMapFromLocal(so.data.map);
        }
    }

    /**
     * Вернуть сериализованное состояние игры для отправки клиенту
     */
    public function getSerializedData():String {
        Cell(map[0][0]).plantType = 1;
        Cell(map[0][0]).plantLevel = 1;

        var serializeData:Object = [];
        for (var i:int = 0; i < AppSettings.GRID_SIZE; i++) {
            for (var j:int = 0; j < AppSettings.GRID_SIZE; j++) {
                // Собираем только заполненные ячейки
                var cell:Cell = Cell(map[i][j]);
                if (cell.hasContent) {
                    serializeData.push(cell.serialize());
                }
            }
        }
        return JSON.encode(serializeData);
    }

    /**
     * Собрать пустую мапу
     */
    private function getEmptyMap():Object {
        var out:Object = {};
        for (var i:int = 0; i < AppSettings.GRID_SIZE; i++) {
            out[i] = {};
            for (var j:int = 0; j < AppSettings.GRID_SIZE; j++) {
                out[i][j] = new Cell(new Point(i, j));
            }
        }
        return out;
    }

    /**
     * Собрать карту из SharedObject
     */
    private function getMapFromLocal(map:Object):Object {
        for (var i:int = 0; i < AppSettings.GRID_SIZE; i++) {
            for (var j:int = 0; j < AppSettings.GRID_SIZE; j++) {
                var cell:Cell = new Cell(new Point(i, j));
                cell.fill(map[i][j]);
                map[i][j] = cell;
            }
        }
        return map;
    }
}
}
