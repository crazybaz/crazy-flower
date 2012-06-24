/**
 * @author baz
 */
package mvc.model {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;
import flash.geom.Point;

public class MouseCursor {
    private var icon:DisplayObject;

    public var context:DisplayObjectContainer;

    public function MouseCursor() {
    }

    public function removeIcon():void {
        icon && context.contains(icon) && context.removeChild(icon);
        context.removeEventListener(MouseEvent.MOUSE_MOVE, updateIconPosition);
        this.icon = null;
    }

    public function setIcon(icon:DisplayObject, mousePoint:Point):void {
        removeIcon();
        this.icon = icon;
        context.addChild(icon);
        context.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        updateIconPosition(mousePoint.x, mousePoint.y);
    }

    private function onMouseMove(e:MouseEvent):void {
        updateIconPosition(e.stageX, e.stageY);
    }

    private function updateIconPosition(mousePointX:Number, mousePointY:Number):void {
        icon.x = mousePointX + 10;
        icon.y = mousePointY + 10;
    }
}
}
