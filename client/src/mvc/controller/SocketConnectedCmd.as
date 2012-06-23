/**
 * @author baz
 */
package mvc.controller {
import mvc.model.RequestProxy;

import org.robotlegs.mvcs.Command;

public class SocketConnectedCmd extends Command {

    [Inject]
    public var requestProxy:RequestProxy

    override public function execute():void {
        // Запросить данные карты
        requestProxy.sendSyncRequest();

        // Игровой экран
        contextView.addChild(new MainView());
    }
}
}
