/**
 * @author baz
 */
package me.silvertoad.nano.impl {
import flash.display.Bitmap;
import flash.display.Shape;
import flash.events.MouseEvent;

import me.silvertoad.nano.core.button.NanoAbstractButton;

public class NanoIconButton extends NanoAbstractButton {
    private var icon:Bitmap;
    private var shadow:Shape;
    private var shadowMask:Bitmap;

    public function NanoIconButton(icon:Bitmap) {
        this.icon = icon;
        shadow = new Shape();

        shadowMask = new Bitmap(icon.bitmapData);
        shadowMask.width = icon.width;
        shadowMask.height = icon.height;
        shadowMask.cacheAsBitmap = true;

        render(0);
        add(shadowMask).add(icon).add(shadow);
        build();
    }

    private function render(alpha:Number):void {
        shadow.graphics.clear();
        shadow.graphics.beginFill(0x666666, alpha);
        shadow.graphics.drawRect(0, 0, icon.width, icon.height);
        shadow.graphics.endFill();
        shadow.cacheAsBitmap = true;
        shadow.mask = shadowMask;
    }

    override protected function mouseOverHandler(event:MouseEvent):void {
        render(0.15);
    }

    override protected function mouseOutHandler(event:MouseEvent):void {
        render(0);
    }

    override protected function mouseDownHandler(event:MouseEvent):void {
        render(0.5);
    }

    override protected function mouseUpHandler(event:MouseEvent):void {
        render(0.15);
    }
}
}
