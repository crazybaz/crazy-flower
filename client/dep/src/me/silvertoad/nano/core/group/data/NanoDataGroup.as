/**
 * User: silvertoad
 * Date: 11/11/11
 */
package me.silvertoad.nano.core.group.data {
import flash.display.DisplayObject;
import flash.events.MouseEvent;

import me.silvertoad.nano.core.group.NanoGroup;
import me.silvertoad.nano.core.group.data.event.NanoItemClickEvent;
import me.silvertoad.nano.core.group.data.renderer.INanoItemRenderer;
import me.silvertoad.nano.core.group.layout.INanoLayout;

/**
 * Класс отображающий данные из dataProvider
 */
public class NanoDataGroup extends NanoGroup {

    // ---------- class fields ----------

    private var _dataProvider:Array;

    private var _rendererClass:Class;

    /**
     * Конструктор, конфигурируемый INanoLayout
     * @param layout
     */
    public function NanoDataGroup(layout:INanoLayout = null) {
        super(layout);
    }

    // ---------- properties ----------

    /**
     * Данные по которым будет строится отображение
     */
    public function get dataProvider():Array {
        return _dataProvider;
    }

    /**
     * @private
     */
    public function set dataProvider(dataProvider:Array):void {
        while (numChildren) {
            removeAt(0);
        }
        _dataProvider = dataProvider;
        for (var i:int = 0; i < dataProvider.length; i++) {
            var renderer:INanoItemRenderer = getRendererInstance();
            renderer.data = dataProvider[i];
            var element:DisplayObject = DisplayObject(renderer);
            element.addEventListener(MouseEvent.CLICK, itemClickHandler, false, 0, true);
            add(element);
        }
    }

    /**
     * Класс рендерера для данных
     */
    public function get itemRenderer():Class {
        return _rendererClass;
    }

    /**
     * @private
     */
    public function set itemRenderer(value:Class):void {
        _rendererClass = value;
    }

    // ---------- syntactic sugar ----------

    public function suDataProvider(dataProvider:Array):NanoDataGroup {
        this.dataProvider = dataProvider;
        return this;
    }

    public function suItemRenderer(value:Class):NanoDataGroup {
        this.itemRenderer = value;
        return this;
    }

    // ---------- private & protected methods ----------

    /**
     * Вернуть новый инстанс рендерера
     */
    private function getRendererInstance():INanoItemRenderer {
        var instance:INanoItemRenderer = new _rendererClass();
        if (!(instance is DisplayObject)) {
            throw new Error(_rendererClass + "is not DisplayObject")
        }
        return instance;
    }

    private function itemClickHandler(event:MouseEvent):void {
        dispatchEvent(new NanoItemClickEvent(NanoItemClickEvent.ITEM_CLICK, INanoItemRenderer(event.currentTarget).data));
    }
}
}
