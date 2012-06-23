/**
 * @author baz
 */
package core {
import flash.geom.Point;

/**
 * Класс описывающий состояние ячейки на игровом поле
 */
public class Cell {
    // Основние поля, участвующие в сериализации
    public var plantType:int;
    public var plantLevel:int;
    public var isoX:int;
    public var isoY:int;

    // Флаг необходимости обновления
    public var isUpdated:Boolean;


    public function Cell(isoPosition:Point) {
        this.isoX = isoPosition.x;
        this.isoY = isoPosition.y;
    }

    public function get isoPosition():Point {
        return new Point(isoX, isoY);
    }

    public function get hasContent():Boolean {
        return !!plantType;
    }

    /**
     * Собрать данные для сериализации
     * @return
     */
    public function serialize():Object {
        return {plantType:plantType, plantLevel:plantLevel, isoX:isoX, isoY:isoY};
    }

    /**
     * Заполнить свойства
     */
    public function fill(data:Object):void {
        for (var key:String in data) {
            this[key] = data[key];
        }
    }

    /**
     * Обновить
     */
    public function update(data:Object):void {
        for (var key:String in data) {
            if (this[key] != data[key]) {
                this[key] = data[key];
                isUpdated = true;
            }
        }
    }

    /**
     * Очистить
     */
    public function cleanup():void {
        plantType = 0;
        plantLevel = 0;
        isUpdated = true;
    }
}
}
