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
    private var _isUpdated:Boolean;
    public function get isUpdated():Boolean {
        return _isUpdated;
    }

    public function set isUpdated(val:Boolean):void {
        _isUpdated = val;
    }


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
     * Вернуть
     * @return
     */
    public function serialize():String {
        return JSON.stringify(this);
    }

    /**
     * Обновить состояние
     */
    public function update(json:Object):void {
        for (var key:String in json) {
            if (json[key] != this[key]) {
                this[key] = json[key];
                _isUpdated = true;
            }
        }
    }
}
}
