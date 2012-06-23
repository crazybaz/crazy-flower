/**
 * @author baz
 */
package mvc.controller {
import flash.events.Event;

import mvc.model.RequestProxy;

import org.robotlegs.mvcs.Command;

public class AppStartCmd extends Command {

    [Inject]
    public var event:Event;

    [Inject]
    public var requestProxy:RequestProxy

    override public function execute():void {
        // Соединение
        requestProxy.init();
    }
}
}
