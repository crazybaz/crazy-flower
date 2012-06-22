/**
 * @author baz
 */
package mvc.controller {
import flash.events.Event;

import org.robotlegs.mvcs.Command;

public class AppStartCmd extends Command {

    [Inject]
    public var event:Event;

    override public function execute():void {
        // Игровой экран
        contextView.addChild(new MainView());
    }
}
}
