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
            saveMap();
        } else {
            map = getMapFromLocal(so.data.map);
        }
    }

    /**
     * Вернуть сериализованное состояние игры для отправки клиенту
     */
    public function getSerializedData():String {
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
     * Поднять уровень у растений
     */
    public function levelUp():void {
        for (var i:int = 0; i < AppSettings.GRID_SIZE; i++) {
            for (var j:int = 0; j < AppSettings.GRID_SIZE; j++) {
                var cell:Cell = Cell(map[i][j]);
                if (cell.hasContent) {
                    cell.plantLevel = Math.min(cell.plantLevel + 1, AppSettings.MAX_PLANT_LEVEL);
                }
            }
        }
        saveMap();
    }

    /**
     * Посадить растение
     */
    public function plant(plantType:int, i:int, j:int):void {
        var cell:Cell = Cell(map[i][j]);
        if (cell.hasContent == false) {
            cell.plantType = plantType;
            cell.plantLevel = 1;
            saveMap();
        }
    }

    /**
     * Сохранить
     */
    private function saveMap():void {
        var data:Array = [];
        for (var i:int = 0; i < AppSettings.GRID_SIZE; i++) {
            for (var j:int = 0; j < AppSettings.GRID_SIZE; j++) {
                var cell:Cell = Cell(map[i][j]);
                cell.hasContent && data.push(cell.serialize());
            }
        }

        so.data.map = data;
        so.flush();
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
    private function getMapFromLocal(data:Array):Object {
        var map:Object = getEmptyMap();
        for each (var cellData:Object in data) {
            var cell:Cell = map[cellData["isoX"]][cellData["isoY"]];
            cell.fill(cellData);
        }
        return map;
    }
}
}
