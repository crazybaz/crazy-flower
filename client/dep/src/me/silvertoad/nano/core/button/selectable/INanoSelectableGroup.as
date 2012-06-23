/**
 * User: silvertoad
 * Date: 11/18/11
 */
package me.silvertoad.nano.core.button.selectable {
public interface INanoSelectableGroup {
    function addButton(button:INanoSelectableButton):void;

    function removeButton(button:INanoSelectableButton):void;

    function get selectedButton():INanoSelectableButton;

    function set selectedButton(value:INanoSelectableButton):void;

    function get selectedIndex():int;

    function set selectedIndex(value:int):void;

}
}
