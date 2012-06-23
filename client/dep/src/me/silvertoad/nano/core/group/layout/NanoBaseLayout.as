/**
 * User: silvertoad
 * Date: 11/11/11
 */
package me.silvertoad.nano.core.group.layout {
import flash.display.DisplayObject;

import me.silvertoad.nano.core.group.NanoGroup;
import me.silvertoad.nano.core.group.layout.align.NanoHorizontalAlign;
import me.silvertoad.nano.core.group.layout.align.NanoVerticalAlign;

/**
 * Базовая реализация INanoLayout
 */
public class NanoBaseLayout implements INanoLayout {

    // ---------- class fields ----------

    protected var _container:NanoGroup;

    protected var _gap:Number = 0;

    protected var _paddingLeft:Number = 0;

    protected var _paddingRight:Number = 0;

    protected var _paddingTop:Number = 0;

    protected var _paddingBottom:Number = 0;

    protected var _horizontalAlign:String = NanoHorizontalAlign.CENTER;

    protected var _verticalAlign:String = NanoVerticalAlign.MIDDLE;

    /**
     * Конструктор настраивающий данных лэйаут
     * @param gap
     * @param paddingLeft
     * @param paddingRight
     * @param paddingTop
     * @param paddingBottom
     */
    public function NanoBaseLayout(paddingLeft:Number = 0, paddingRight:Number = 0, paddingTop:Number = 0, paddingBottom:Number = 0) {
        _paddingLeft = paddingLeft;
        _paddingRight = paddingRight;
        _paddingTop = paddingTop;
        _paddingBottom = paddingBottom;
    }

    // ---------- properties ----------

    /**
     * @inheritDoc
     */
    public function set container(value:NanoGroup):void {
        _container = value;
    }

    /**
     * @inheritDoc
     */
    public function get container():NanoGroup {
        return _container;
    }

    /**
     * @inheritDoc
     */
    public function set gap(value:Number):void {
        _gap = value;
    }

    /**
     * @inheritDoc
     */
    public function get gap():Number {
        return _gap;
    }

    /**
     * @inheritDoc
     */
    public function set paddingLeft(value:Number):void {
        _paddingLeft = value;
    }

    /**
     * @inheritDoc
     */
    public function get paddingLeft():Number {
        return _paddingLeft;
    }

    /**
     * @inheritDoc
     */
    public function set paddingRight(value:Number):void {
        _paddingRight = value;
    }

    /**
     * @inheritDoc
     */
    public function get paddingRight():Number {
        return _paddingRight;
    }

    /**
     * @inheritDoc
     */
    public function set paddingTop(value:Number):void {
        _paddingTop = value;
    }

    /**
     * @inheritDoc
     */
    public function get paddingTop():Number {
        return _paddingTop;
    }

    /**
     * @inheritDoc
     */
    public function set paddingBottom(value:Number):void {
        _paddingBottom = value;
    }

    /**
     * @inheritDoc
     */
    public function get paddingBottom():Number {
        return _paddingBottom;
    }

    /**
     * @inheritDoc
     */
    public function get horizontalAlign():String {
        return _horizontalAlign;
    }

    /**
     * @inheritDoc
     */
    public function set horizontalAlign(value:String):void {
        _horizontalAlign = value;
    }

    /**
     * @inheritDoc
     */
    public function get verticalAlign():String {
        return _verticalAlign;
    }

    /**
     * @inheritDoc
     */
    public function set verticalAlign(value:String):void {
        _verticalAlign = value;
    }

    // ---------- public methods ----------

    /**
     * @inheritDoc
     */
    public function realign():void {
        alignVertical();
        alignHorizontal();
    }

    // ---------- private & protected methods ----------

    /**
     * Произвести выравнивание по вертикали
     */
    protected function alignVertical():void {
        var maxHeight:Number = getMaxElementSide(false);

        for (var i:int = 0; i < container.numChildren; i++) {
            var element:DisplayObject = container.getChildAt(i);
            switch (_verticalAlign) {
                case NanoVerticalAlign.TOP:
                    element.y = paddingTop;
                    break;
                case NanoVerticalAlign.MIDDLE:
                    if (container.fixedHeight) {
                        //TODO: подумать, может быть сдесь стоит прибавить paddingTop и отнять paddingBottom
                        element.y = (container.fixedHeight - element.height + paddingTop - paddingBottom) / 2;
                    } else {
                        element.y = paddingTop + (maxHeight - element.height) / 2;
                    }
                    break;
                case NanoVerticalAlign.BOTTOM:
                    if (container.fixedHeight) {
                        element.y = container.fixedHeight - element.height - paddingBottom;
                    } else {
                        element.y = paddingTop + (maxHeight - element.height);
                    }
                    break;
            }
        }

        container.measureHeight = paddingTop + maxHeight + paddingBottom;
    }

    /**
     * Произвести выравнивание по горизонтали
     */
    protected function alignHorizontal():void {
        var maxWidth:Number = getMaxElementSide(true);

        for (var i:int = 0; i < container.numChildren; i++) {
            var element:DisplayObject = container.getChildAt(i);
            switch (_horizontalAlign) {
                case NanoHorizontalAlign.LEFT:
                    element.x = paddingLeft;
                    break;
                case NanoHorizontalAlign.CENTER:
                    //TODO: подумать, может быть сдесь стоит прибавить paddingLeft и отнять paddingRight
                    if (container.fixedWidth) {
                        element.x = (container.fixedWidth - element.width + paddingLeft - paddingRight) / 2;
                    } else {
                        element.x = paddingLeft + (maxWidth - element.width) / 2;
                    }
                    break;
                case NanoHorizontalAlign.RIGHT:
                    if (container.fixedWidth) {
                        element.x = container.fixedWidth - element.width - paddingRight;
                    } else {
                        element.x = paddingLeft + (maxWidth - element.width);
                    }
                    break;
            }
        }

        container.measureWidth = paddingLeft + maxWidth + paddingRight;
    }

    /**
     * Найти наибольшую сторону среди элементов группы
     * @param byWidth если, true ищет по ширине, false - по высоте
     * @return наибольшая сторона
     */
    protected function getMaxElementSide(byWidth:Boolean = true):Number {
        var maxSide:Number = 0;
        for (var i:int = 0; i < container.numChildren; i++) {
            var element:DisplayObject = container.getChildAt(i);
            var tmpSide:Number = byWidth ? element.width : element.height;
            maxSide = tmpSide > maxSide ? tmpSide : maxSide;
        }
        return maxSide;
    }
}
}
