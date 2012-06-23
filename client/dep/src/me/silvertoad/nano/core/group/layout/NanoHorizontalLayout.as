/**
 * User: silvertoad
 * Date: 11/11/11
 */
package me.silvertoad.nano.core.group.layout {
import flash.display.DisplayObject;

import me.silvertoad.nano.core.group.layout.align.NanoHorizontalAlign;

/**
 * Реализация INanoLayout для горизонтального выравнивания
 */
public class NanoHorizontalLayout extends NanoBaseLayout {

    /**
     * Конструктор класса, настраивающий данный лэйаут
     * @param gap
     * @param paddingLeft
     * @param paddingRight
     * @param paddingTop
     * @param paddingBottom
     */
    public function NanoHorizontalLayout(gap:Number = 10, paddingLeft:Number = 0, paddingRight:Number = 0, paddingTop:Number = 0, paddingBottom:Number = 0) {
        super(paddingLeft, paddingRight, paddingTop, paddingBottom);
        _gap = gap;
    }

    /**
     * @inheritDoc
     */
    override protected function alignHorizontal():void {
        var prevElement:DisplayObject;

        // Считаем щирину всех элеметнов (без отступов)
        var elementsWidth:Number = -gap;
        for (var j:int = 0; i < container.numChildren; i++) {
            var e:DisplayObject = container.getChildAt(i);
            elementsWidth += (e.width + gap);
        }

        for (var i:int = 0; i < container.numChildren; i++) {
            var element:DisplayObject = container.getChildAt(i);
            if (!prevElement) {
                switch (_horizontalAlign) {
                    case NanoHorizontalAlign.LEFT:
                        element.x = paddingLeft;
                        break;
                    case NanoHorizontalAlign.CENTER:
                        if (container.fixedWidth) {
                            element.x = (container.fixedWidth - elementsWidth + paddingLeft - paddingRight) / 2;
                        } else {
                            element.x = paddingLeft;
                        }
                        break;
                    case NanoHorizontalAlign.RIGHT:
                        if (container.fixedWidth) {
                            element.x = container.fixedWidth - elementsWidth - paddingRight;
                        } else {
                            element.x = paddingLeft;
                        }
                        break;
                }
            } else {
                element.x = prevElement.x + prevElement.width + gap;
            }
            prevElement = element;
        }

        container.measureWidth = paddingLeft + elementsWidth + paddingRight;
    }
}
}
