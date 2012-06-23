/**
 * User: silvertoad
 * Date: 11/18/11
 */
package me.silvertoad.nano.core.view {
import flash.display.DisplayObject;

import me.silvertoad.nano.core.group.NanoGroup;

public class NanoViewStack extends NanoGroup {

    // ---------- class fields ----------

    protected var _index:int;

    protected var _selectedPage:DisplayObject;

    protected var _pages:Vector.<DisplayObject> = new Vector.<DisplayObject>();

    public function NanoViewStack() {
    }

    public function addPage(page:DisplayObject):void {
        _pages.push(page);
        if (!_selectedPage) {
            selectedIndex = 0;
        }
    }

    public function get selectedIndex():int {
        return _index;
    }

    public function set selectedIndex(index:int):void {
        if (_selectedPage && this.contains(_selectedPage)) this.remove(_selectedPage);
        this.add(_selectedPage = _pages[_index = index]);
        build();
    }

    public function get selectedPage():DisplayObject {
        return _selectedPage;
    }

    public function set selectedPage(page:DisplayObject):void {
        var selectedIndex:Number = _pages.indexOf(page);
        if (selectedIndex != -1) {
            this.selectedIndex = selectedIndex;
        } else {
            throw new Error("Page not found in stack: " + page + ".");
        }
    }

    public function get numPages():int {
        return _pages.length;
    }

    // ---------- syntactic sugar ----------

    public function suAddPage(page:DisplayObject):NanoViewStack {
        addPage(page);
        return this;
    }

    public function suSetIndex(index:int):NanoViewStack {
        selectedIndex = index;
        return this;
    }
}
}
