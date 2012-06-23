/**
 * User: silvertoad
 * Date: 11/18/11
 */
package me.silvertoad.nano.core.button.selectable {
public class NanoRadioGroup implements INanoSelectableGroup {
    protected var buttons:Vector.<INanoSelectableButton> = new Vector.<INanoSelectableButton>();

    private var _selectedButton:INanoSelectableButton;

    private var _selectedIndex:int;

    public function addButton(button:INanoSelectableButton):void {
        buttons.push(button);
    }

    public function removeButton(button:INanoSelectableButton):void {
        buttons.splice(buttons.indexOf(button), 1);
    }

    public function get selectedButton():INanoSelectableButton {
        return _selectedButton;
    }

    public function set selectedButton(value:INanoSelectableButton):void {
        selectedIndex = buttons.indexOf(value);
    }

    public function get selectedIndex():int {
        return _selectedIndex;
    }

    public function set selectedIndex(value:int):void {
        if (_selectedButton) _selectedButton.select = false;
        buttons[value].select = true;
        _selectedButton = buttons[value];
        _selectedIndex = value;
    }
}
}
