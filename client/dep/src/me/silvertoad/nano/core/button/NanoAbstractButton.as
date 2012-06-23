/**
 * User: silvertoad
 * Date: 11/15/11
 */
package me.silvertoad.nano.core.button {
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;

import me.silvertoad.nano.core.group.NanoGroup;

public class NanoAbstractButton extends NanoGroup {

    // ---------- class fields ----------

    private var isEnabled:Boolean = true;

    public function NanoAbstractButton() {
        this.buttonMode = true;
        this.useHandCursor = true;
        this.mouseChildren = false;

        this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true);
        this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true);
        this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
        this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
        this.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
    }

    // ---------- properties ----------

    public function get enabled():Boolean {
        return isEnabled;
    }

    public function set enabled(value:Boolean):void {
        if (isEnabled != value) {
            if (value) {
                this.transform.colorTransform = new ColorTransform();
            } else {
                var color:ColorTransform = this.transform.colorTransform;
                color.redMultiplier = 0.85;
                color.blueMultiplier = 0.85;
                color.greenMultiplier = 0.85;
                this.transform.colorTransform = color;
            }
        }
        mouseEnabled = isEnabled = value;
    }

    // ---------- private & protected methods ----------

    protected function mouseOutHandler(event:MouseEvent):void {
    }

    protected function mouseOverHandler(event:MouseEvent):void {
    }

    protected function mouseUpHandler(event:MouseEvent):void {
    }

    protected function mouseLeaveHandler(event:Event):void {
    }

    protected function mouseDownHandler(event:MouseEvent):void {
    }
}
}