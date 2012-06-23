/**
 * Created by IntelliJ IDEA.
 * User: silvertoad
 * Date: 11/10/11
 * Time: 12:10 PM
 * To change this template use File | Settings | File Templates.
 */
package me.silvertoad.nano.core.group {
import flash.display.DisplayObject;
import flash.display.Sprite;

import me.silvertoad.nano.core.group.layout.INanoLayout;
import me.silvertoad.nano.core.group.layout.NanoBaseLayout;

/**
 * Класс базового контейнера для выравнивания графических элементов
 */
public class NanoGroup extends Sprite {

    // ---------- class fields ----------

    private var _layout:INanoLayout;

    private var _measureHeight:Number;

    private var _measureWidth:Number;

    private var _fixedWidth:Number;

    private var _fixedHeight:Number;

    /**
     * Конструктор класса, конфигурирующий группу экземпляром INanoLayout,
     * layout по эмолчанию - NanoBaseLayout
     * @param layout
     */
    public function NanoGroup(layout:INanoLayout = null) {
        this.layout = layout ? layout : new NanoBaseLayout();
    }

    // ---------- properties ----------

    /**
     * Класс выравнивание для этой группы
     */
    public function get layout():INanoLayout {
        return _layout;
    }

    /**
     * @private
     */
    public function set layout(value:INanoLayout):void {
        if (_layout) _layout.container = null;
        _layout = value;
        _layout.container = this;
    }

    /**
     * Фиусированная высота группы (данное число всегда будет возвращаться в свойстве height)
     */
    public function get fixedHeight():Number {
        return _fixedHeight;
    }

    /**
     * Фиксированная ширина группы (данное число всегда будет возвращаться в свойстве width)
     */
    public function get fixedWidth():Number {
        return _fixedWidth;
    }

    /**
     * Установить рассчетную высоту компонента
     */
    public function set measureHeight(measureHeight:Number):void {
        _measureHeight = measureHeight;
    }

    /**
     * Установить рассчетную ширину компонента
     */
    public function set measureWidth(measureWidth:Number):void {
        _measureWidth = measureWidth;
    }

    /**
     * Вернуть ширину группы.
     * Возвращает _fixedWidth, если данный параметр задан, иначе
     * возвращает _measureWidth, если данный параметр задан, иначе
     * возвращает super.width
     */
    override public function get width():Number {
        return _fixedWidth ? _fixedWidth : (_measureWidth ? _measureWidth : super.width);
    }

    /**
     * Установить фиксированную ширину группы
     */
    override public function set width(value:Number):void {
        _fixedWidth = value;
    }

    /**
     * Вернуть высоту группы.
     * Возвращает _fixedHeight, если данный параметр задан, иначе
     * возвращает _measureHeight, если данный параметр задан, иначе
     * возвращает super.height
     */
    override public function get height():Number {
        return _fixedHeight ? _fixedHeight : (_measureHeight ? _measureHeight : super.height);
    }

    /**
     * Установить фиксированную высоту группы
     */
    override public function set height(value:Number):void {
        _fixedHeight = value;
    }

    // ---------- public methods ----------

    /**
     * Добавить визульный компонет element в группу
     * @param element
     * @return ссылка на данную группу, для добавления по цепочке
     */
    public function add(element:DisplayObject):NanoGroup {
        return addAt(element, this.numChildren);
    }

    /**
     * Добавить визуальный компонент element в группу с нижестояшим индексом index
     * @param element
     * @param index
     * @return ссылка на данную группу, для добавления по цепочке
     */
    public function addAt(element:DisplayObject, index:int):NanoGroup {
        this.addChildAt(element, index);
        return this;
    }

    public function setAt(element:DisplayObject, x:Number = NaN, y:Number = NaN):NanoGroup {
        if (!isNaN(x)) element.x = x;
        if (!isNaN(y)) element.y = y;
        return this;
    }

    /**
     * Произвести выравнивание элементов группы
     * @return ссылка на данную группу
     */
    public function build():NanoGroup {
        layout.realign();
        return this;
    }

    /**
     * Удалить визуальный компонент element из группы
     * @param element
     * @return удаленный визуальный компонент element
     */
    public function remove(element:DisplayObject):DisplayObject {
        return removeAt(this.getChildIndex(element));
    }

    /**
     * Удалить визуальный компонент под индексом index из группы
     * @param index
     * @return удаленный визуальный компонент под индексом index
     */
    public function removeAt(index:int):DisplayObject {
        return this.removeChildAt(index);
    }

    // ---------- syntactic sugar ----------

    public function suGap(value:Number):NanoGroup {
        layout.gap = value;
        return this;
    }

    public function suPadLeft(value:Number):NanoGroup {
        layout.paddingLeft = value;
        return this;
    }

    public function suPadRight(value:Number):NanoGroup {
        layout.paddingRight = value;
        return this;
    }

    public function suPadTop(value:Number):NanoGroup {
        layout.paddingTop = value;
        return this;
    }

    public function suPadBottom(value:Number):NanoGroup {
        layout.paddingBottom = value;
        return this;
    }

    public function suHAlign(value:String):NanoGroup {
        layout.horizontalAlign = value;
        return this;
    }

    public function suVAlign(value:String):NanoGroup {
        layout.verticalAlign = value;
        return this;
    }

    public function suWidth(value:Number):NanoGroup {
        width = value;
        return this;
    }

    public function suHeight(value:Number):NanoGroup {
        height = value;
        return this;
    }

    public function suX(value:Number):NanoGroup {
        x = value;
        return this;
    }

    public function suY(value:Number):NanoGroup {
        y = value;
        return this;
    }
}
}