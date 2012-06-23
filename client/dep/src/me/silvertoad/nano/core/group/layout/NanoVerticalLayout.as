/**
 * User: silvertoad
 * Date: 11/11/11
 */
package me.silvertoad.nano.core.group.layout {
import flash.display.DisplayObject;

import me.silvertoad.nano.core.group.layout.align.NanoVerticalAlign;

/**
 * Реализация INanoLayout для горизонтального выравнивания
 */
public class NanoVerticalLayout extends NanoBaseLayout {

    /**
     * Конструктор класса, настраивающий данный лэйаут
     * @param gap
     * @param paddingLeft
     * @param paddingRight
     * @param paddingTop
     * @param paddingBottom
     */
    public function NanoVerticalLayout(gap:Number = 10, paddingLeft:Number = 0, paddingRight:Number = 0, paddingTop:Number = 0, paddingBottom:Number = 0) {
        super(paddingLeft, paddingRight, paddingTop, paddingBottom);
        _gap = gap;
    }

    /**
     * @inheritDoc
     */
    override protected function alignVertical():void {
        var prevElement:DisplayObject;

        // Считаем щирину всех элеметнов (без отступов)
        var elementsHeight:Number = -gap;
        for (var j:int = 0; i < container.numChildren; i++) {
            var e:DisplayObject = container.getChildAt(i);
            elementsHeight += (e.height + gap);
        }

        for (var i:int = 0; i < container.numChildren; i++) {
            var element:DisplayObject = container.getChildAt(i);
            if (!prevElement) {
                switch (_verticalAlign) {
                    case NanoVerticalAlign.TOP:
                        element.y = paddingTop;
                        break;
                    case NanoVerticalAlign.MIDDLE:
                        if (container.fixedHeight) {
                            element.y = (container.fixedHeight - elementsHeight + paddingTop - paddingBottom) / 2;
                        } else {
                            element.y = paddingTop;
                        }
                        break;
                    case NanoVerticalAlign.BOTTOM:
                        if (container.fixedHeight) {
                            element.y = container.fixedHeight - elementsHeight - paddingBottom;
                        } else {
                            element.y = paddingTop;
                        }
                        break;
                }
            } else {
                element.y = prevElement.y + prevElement.height + gap;
            }
            prevElement = element;
        }

        container.measureHeight = paddingTop + elementsHeight + paddingBottom;
    }
}
}
