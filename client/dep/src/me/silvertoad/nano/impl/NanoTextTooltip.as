/**
 * @author baz
 */
package me.silvertoad.nano.impl {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

import me.silvertoad.nano.core.group.NanoGroup;
import me.silvertoad.nano.core.text.NanoTextField;

/**
 * Базовый тултип
 */
public class NanoTextTooltip extends NanoGroup {
    private static const PADDING:Number = 2;
    private static const PADDING_LEFT:Number = 15;
    private static const PADDING_TOP:Number = 15;

    private var target:DisplayObject;
    private var context:Stage;

    protected var textField:NanoTextField;
    protected var background:Sprite;

    public function NanoTextTooltip(target:DisplayObject, text:String) {
        this.target = target;

        mouseChildren = false;
        mouseEnabled = false;

        // Layout
        textField = new NanoTextField();
        textField.mouseEnabled = false;
        textField.x = textField.y = PADDING;
        textField.autoSize = TextFieldAutoSize.LEFT;
        addChild(textField);

        background = new Sprite();
        addChildAt(background, 0);

        this.text = text;

        // Context
        if (target.stage) {
            setContext();
        } else {
            target.addEventListener(Event.ADDED_TO_STAGE, onStage);
        }

        function onStage(e:Event):void {
            target.removeEventListener(Event.ADDED_TO_STAGE, onStage);
            setContext();
        }

        function setContext():void {
            context = target.stage;
        }

        // События
        target.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
        target.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
    }

    /**
     * Перерисовать фон
     */
    private function rebuildBackground():void {
        background.graphics.clear();
        background.graphics.lineStyle(1, 0x989898);
        background.graphics.beginFill(0xfffddd, 0.7);
        background.graphics.drawRect(0, 0, textField.width + PADDING * 2, textField.height + PADDING * 2);
        background.graphics.endFill();
        background.alpha = 0.8;
    }

    /**
     * Аксессоры на текст
     */
    public function set text(value:String):void {
        textField.text = value;
        rebuildBackground();
    }

    public function get text():String {
        return textField.text;
    }

    /**
     * События
     */
    protected function onMouseOver(e:MouseEvent):void {
        show();
    }

    protected function onMouseOut(e:MouseEvent):void {
        hide();
    }

    public function show():void {
        target.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        context.addChild(this);
        onMouseMove();
    }

    public function hide():void {
        target.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        context.removeChild(this);
    }

    private function onMouseMove(e:MouseEvent = null):void {
        var deltaX:Number = context.mouseX + this.width + PADDING_LEFT > context.stageWidth
                ? (context.mouseX - this.width)
                : (context.mouseX) + PADDING_LEFT;
        var deltaY:Number = context.mouseY + this.height + PADDING_TOP > context.stageHeight
                ? (context.mouseY - this.height)
                : (context.mouseY) + PADDING_TOP;
        this.x = deltaX;
        this.y = deltaY;
    }
}
}
