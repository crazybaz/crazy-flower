/**
 * @author baz
 */
package lib {
import flash.display.DisplayObject;

public class ScaleHelper {
    public static const X_AXIS:String = 'X_AXIS';
    public static const Y_AXIS:String = 'Y_AXIS';

    /**
     * Подгоняет объект по стороне
     * @param object изменяемый объект
     * @param scaleSize новая высота
     * @param axis сторона которую изменяем
     */
    public static function scaleBySide(object:DisplayObject, scaleSize:Number, axis:String):void {
        if (!object) return;
        var scale:Number = scaleSize / (axis == X_AXIS ? object.width : object.height);
        object.width *= scale;
        object.height *= scale;
    }

    /**
     * Вписывает объект в квадрат со стороной @scaleSize увеличивая или уменьшая
     * @param object
     * @param scaleSize
     */
    public static function scaleByMaxSide(object:DisplayObject, scaleSize:Number):void {
        scaleBySide(object, scaleSize, X_AXIS);
        if (object.height > scaleSize) {
            scaleBySide(object, scaleSize, Y_AXIS);
        }
    }

    /**
     * Подогнать размер объекта так чтобы он с наименьшими потерями полностью заполнил прямоугольник
     * @param object
     * @param widthSize
     * @param heightSize
     */
    public static function scaleByMinSide(object:DisplayObject, widthSize:Number, heightSize:Number):void {
        if (object.width < widthSize) {
            scaleBySide(object, widthSize, X_AXIS);
        }
        if (object.height < heightSize) {
            scaleBySide(object, heightSize, Y_AXIS);
        }
    }
}

}
