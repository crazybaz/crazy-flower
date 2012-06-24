/**
 * @author baz
 */
package mvc.model {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;

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

    public function setIcon(icon:DisplayObject):void {
        removeIcon();
        this.icon = icon;
        context.addChild(icon);
        context.addEventListener(MouseEvent.MOUSE_MOVE, updateIconPosition);
    }

    private function updateIconPosition(e:MouseEvent):void {
        icon.x = e.stageX + 10;
        icon.y = e.stageY + 10;
    }
}
}
