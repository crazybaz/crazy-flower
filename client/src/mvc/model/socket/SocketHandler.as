/**
 * @author baz
 */
package mvc.model.socket {
import event.SocketEvent;

import flash.events.Event;

import org.robotlegs.mvcs.Actor;

public class SocketHandler extends Actor implements ISocketHandler {

    public function SocketHandler() {
    }

    public function onConnect():void {
        dispatch(new Event(SocketEvent.CONNECTED));
    }

    public function onData(message:String):void {

    }
}
}
