/**
 * User: silvertoad
 * Date: 11/18/11
 */
package me.silvertoad.nano.core.button.selectable {
import flash.events.IEventDispatcher;

public interface INanoSelectableButton extends IEventDispatcher {
    function set select(value:Boolean):void;

    function get select():Boolean;

    function set group(group:INanoSelectableGroup):void;

    function get group():INanoSelectableGroup;
}
}
