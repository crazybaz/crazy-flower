/**
 * User: silvertoad
 * Date: 14/11/11
 */
package me.silvertoad.nano.core.group.data.renderer {
/**
 * Интерфейс рендерера
 */
public interface INanoItemRenderer {

    /**
     * Установить данные для этого рендерера
     * @param value
     */
    function set data(value:*):void;

    /**
     * Вернуть данные для эотго рендерера
     * @return
     */
    function get data():*;
}
}
