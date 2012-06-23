/**
 * User: silvertoad
 * Date: 03.12.11
 */
package me.silvertoad.nano.quick.text {
import flash.text.TextField;
import flash.text.TextFieldType;

import me.silvertoad.nano.core.group.NanoGroup;
import me.silvertoad.nano.core.group.layout.align.NanoHorizontalAlign;

public class QuickNanoTextInput extends NanoGroup {

    private var textField:TextField = new TextField();

    public function QuickNanoTextInput() {
        super();
        layout.horizontalAlign = NanoHorizontalAlign.LEFT;
        suWidth(100);
        suHeight(20);
        suPadLeft(2);

        textField.type = TextFieldType.INPUT;
        render(100, 20);
        add(textField).build();
    }

    private function render(width:Number, height:Number):void {
        this.graphics.clear();
        this.graphics.beginFill(0xFFFFFF);
        this.graphics.lineStyle(0.5);
        this.graphics.drawRect(0, 0, width, height);
        this.graphics.endFill();
        textField.width = width;
        textField.height = height;
        build();
    }

    override public function suWidth(value:Number):NanoGroup {
        render(value, height);
        return super.suWidth(value);
    }

    override public function set width(value:Number):void {
        render(value, height);
        super.width = value;
    }

    override public function suHeight(value:Number):NanoGroup {
        render(width, value);
        return super.suHeight(value);
    }

    override public function set height(value:Number):void {
        render(width, value);
        super.height = value;
    }

    public function suText(value:String):QuickNanoTextInput {
        text = value;
        return this;
    }

    public function set text(value:String):void {
        textField.text = value;
    }

    public function get text():String {
        return textField.text;
    }
}
}
