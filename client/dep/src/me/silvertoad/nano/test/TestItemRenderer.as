/**
 * User: silvertoad
 * Date: 14/11/11
 */
package me.silvertoad.nano.test {
import me.silvertoad.nano.core.group.data.renderer.NanoItemRenderer;
import me.silvertoad.nano.core.text.NanoTextField;

public class TestItemRenderer extends NanoItemRenderer {
    override public function set data(value:*):void {
        super.data = value;
        add(TestShape.getRect());
        add(new NanoTextField().suText(value));
        build();
    }
}
}
