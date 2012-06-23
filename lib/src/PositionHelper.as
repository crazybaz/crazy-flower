/**
 * @author baz
 */
package {
import flash.display.DisplayObject;

/*
 * Хелпер центрирует дочерний объект относительно родительского по выбранной оси, с учетом различных
 * позиционирований центра.
 */
public class PositionHelper {

    /**
     * Определяет все необходимые вычислительные переменные для оси Y, затем вызывает непосредственно пересчет
     * @param parentObject родительский объект
     * @param childObject дочерний объект
     * @param ignoreParentAxisPosition игнорировать ли осевую позицию родителя [для групп]
     * @return координата дочернего объекта для правильного центрирования
     */
    public static function centerYAxis(parentObject:DisplayObject, childObject:DisplayObject, ignoreParentAxisPosition:Boolean = false):void {

        var parentAxisPos:Number = ignoreParentAxisPosition ? 0 : parentObject.y;

        var parentSize:Number = parentObject.height;
        var childSize:Number = childObject.height;

        childObject.y = calculateCenter(parentAxisPos, parentSize, childSize);
    }

    /**
     * см. <code>centerYAxis</code>
     */
    public static function centerXAxis(parentObject:DisplayObject, childObject:DisplayObject, ignoreParentAxisPosition:Boolean = false):void {

        var parentAxisPos:Number = ignoreParentAxisPosition ? 0 : parentObject.x;

        var parentSize:Number = parentObject.width;
        var childSize:Number = childObject.width;

        childObject.x = calculateCenter(parentAxisPos, parentSize, childSize);
    }

    /**
     * Центрирует по обеим осям
     */
    public static function centerXYAxises(parentObject:DisplayObject, childObject:DisplayObject, ignoreParentXPosition:Boolean = false, ignoreParentYPosition:Boolean = false):void {

        centerXAxis(parentObject, childObject, ignoreParentXPosition);
        centerYAxis(parentObject, childObject, ignoreParentYPosition);
    }

    /**
     * Выравнивание к низу, см. <code>centerYAxis</code>
     */
    public static function bottomYAxis(parentObject:DisplayObject, childObject:DisplayObject, ignoreParentAxisPosition:Boolean = false):void {

        var parentAxisPos:Number = ignoreParentAxisPosition ? 0 : parentObject.y;

        var parentSize:Number = parentObject.height;
        var childSize:Number = childObject.height;

        childObject.y = calculateCenter(parentAxisPos, parentSize, childSize, false)
    }

    /**
     * Выравнивание к правой стороне, см. <code>centerYAxis</code>
     */
    public static function rightXAxis(parentObject:DisplayObject, childObject:DisplayObject, ignoreParentAxisPosition:Boolean = false):void {

        var parentAxisPos:Number = ignoreParentAxisPosition ? 0 : parentObject.x;

        var parentSize:Number = parentObject.width;
        var childSize:Number = childObject.width;

        childObject.x = calculateCenter(parentAxisPos, parentSize, childSize, false)
    }

    /**
     * Выполняет непосредственно расчет центровой координаты, отталкиваясь от данных, полученных
     * одним из методов <code>**Axis</code>
     * @return
     */
    private static function calculateCenter(parentAxisPos:Number, parentSize:Number, childSize:Number, center:Boolean = true):Number {
        return center ? parentAxisPos + (parentSize - childSize) / 2 : parentAxisPos + parentSize - childSize;
    }
}
}