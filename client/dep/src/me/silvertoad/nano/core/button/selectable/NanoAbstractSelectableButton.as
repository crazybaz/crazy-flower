/**
 * User: silvertoad
 * Date: 11/18/11
 */
package me.silvertoad.nano.core.button.selectable {
import flash.events.MouseEvent;

import me.silvertoad.nano.core.button.NanoAbstractButton;

public class NanoAbstractSelectableButton extends NanoAbstractButton implements INanoSelectableButton {

    protected var _select:Boolean = false;

    protected var _group:INanoSelectableGroup;

    public function NanoAbstractSelectableButton() {
        this.addEventListener(MouseEvent.CLICK, mouseClickHandler, false, 0, true);
    }

    public function set select(value:Boolean):void {
        _select = value;
    }

    public function get select():Boolean {
        return _select;
    }

    public function set group(group:INanoSelectableGroup):void {
        _group = group;
    }

    public function get group():INanoSelectableGroup {
        return _group;
    }

    protected function mouseClickHandler(event:MouseEvent):void {
        _group.selectedButton = this;
    }
}
}
