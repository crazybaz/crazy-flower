/**
 * User: silvertoad
 * Date: 14/11/11
 */
package me.silvertoad.nano.core.group.data.renderer {
import me.silvertoad.nano.core.group.NanoGroup;
import me.silvertoad.nano.core.group.layout.INanoLayout;

/**
 * Базовый класс для рендереров
 */
public class NanoItemRenderer extends NanoGroup implements INanoItemRenderer {

    protected var _data:*;

    /**
     * Конструктор класса, конфигурирующий лэйаут компонента
     * @param layout
     */
    public function NanoItemRenderer(layout:INanoLayout = null) {
        super(layout);
    }

    /**
     * @inheritDoc
     */
    public function set data(value:*):void {
        _data = value;
    }

    /**
     * @inheritDoc
     */
    public function get data():* {
        return _data;
    }
}
}
