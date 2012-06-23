/**
 * User: silvertoad
 * Date: 14/11/11
 */
package me.silvertoad.nano.test {
import flash.display.Sprite;

public class TestShape {

    /**
     * Вернуть прямоугольник случайного размера и цвета
     */
    public static function getRect(sideSize:Number = 20):Sprite {
        var s:Sprite = new Sprite();
        s.graphics.beginFill(0xFFFFFF * Math.random(), 0.3);
        s.graphics.drawRect(0, 0, sideSize + sideSize * Math.random(), sideSize + sideSize * Math.random());
        s.graphics.endFill();
        return s;
    }
}
}
