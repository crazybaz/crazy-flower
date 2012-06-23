/**
 * User: silvertoad
 * Date: 11/11/11
 */
package me.silvertoad.nano.core.group.layout {
import me.silvertoad.nano.core.group.NanoGroup;

/**
 * Интерфейс лэйаута дял Nano фрэймворка
 */
public interface INanoLayout {

    /**
     * Группа над которой будет работать INanoLayout
     */
    function get container():NanoGroup;

    /**
     * @private
     */
    function set container(value:NanoGroup):void;

    /**
     * Расстояние между элеентами
     */
    function get gap():Number;

    /**
     * @private
     */
    function set gap(value:Number):void;

    /**
     * Отступ внутренных элементов слева
     */
    function get paddingLeft():Number;

    /**
     * @private
     */
    function set paddingLeft(value:Number):void;

    /**
     * Отступ внутренных элеметнов справа
     */
    function get paddingRight():Number;

    /**
     * @private
     */
    function set paddingRight(value:Number):void;

    /**
     * Отступ внутренних элементов сверху
     */
    function get paddingTop():Number;

    /**
     * @private
     */
    function set paddingTop(value:Number):void;

    /**
     * Отступ внутренних элементов снизу
     */
    function get paddingBottom():Number;

    /**
     * @private
     */
    function set paddingBottom(value:Number):void;

    /**
     * Вертикальное выраснивание элементов группы
     */
    function get verticalAlign():String;

    /**
     * @private
     */
    function set verticalAlign(value:String):void;

    /**
     * Горизонтальное выравнивание элементов группы
     */
    function get horizontalAlign():String;

    /**
     * @private
     */
    function set horizontalAlign(value:String):void;

    /**
     * Выравныть элементы группы
     */
    function realign():void;
}
}
