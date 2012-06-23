/**
 * User: silvertoad
 * Date: 11/17/11
 */
package me.silvertoad.nano.quick.button {
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import me.silvertoad.nano.core.button.*;
import me.silvertoad.nano.core.text.NanoTextField;

public class QuickNanoButton extends NanoAbstractButton {

    protected var textField:NanoTextField = new NanoTextField();

    protected var btn:Sprite = new Sprite();

    protected var _clickHandler:Function;

    public function QuickNanoButton() {
        add(btn).add(textField);
    }

    public function set label(text:String):void {
        textField.suText(text);
        render(0xFFFFFF);
    }

    public function set clickHandler(clickHandler:Function):void {
        _clickHandler = clickHandler;
    }

    protected function render(colour:uint):void {
        var g:Graphics = btn.graphics;
        g.clear();
        g.beginFill(colour);
        g.lineStyle(2, 0x989993);
        g.drawRoundRectComplex(2, 2, textField.width + 7, textField.height + 2, 5, 5, 5, 5);
        g.endFill();
        build();
    }

    override protected function mouseOutHandler(event:MouseEvent):void {
        render(0xFFFFFF);
    }

    override protected function mouseOverHandler(event:MouseEvent):void {
        render(0xE7E8E3);
    }

    override protected function mouseUpHandler(event:MouseEvent):void {
        render(0xE7E8E3);
    }

    override protected function mouseDownHandler(event:MouseEvent):void {
        render(0xFFFFFF);
    }

    override protected function mouseLeaveHandler(event:Event):void {
        render(0xFFFFFF);
    }

    // ---------- syntactic sugar ----------

    public function suLabel(text:String):QuickNanoButton {
        label = text;
        return this;
    }
}
}