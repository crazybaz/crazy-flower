/**
 * @author baz
 */
package mvc.model.socket {
import event.SocketEvent;
import event.UIEvent;

import flash.events.Event;

import mvc.model.GridModel;

import org.robotlegs.mvcs.Actor;

public class SocketHandler extends Actor implements ISocketHandler {

    [Inject]
    public var gridModel:GridModel;

    public function SocketHandler() {
    }

    public function onReady():void {
        dispatch(new Event(SocketEvent.READY));
    }

    /**
     * В ответ от сервера всегда приходит актуальное состояние игры
     * @param message
     */
    public function onData(message:String):void {
        // Синхронизируем состояние клиента с сервером
        gridModel.sync(JSON.parse(message));

        // Посылаем запрос на обновление
        dispatch(new Event(UIEvent.UPDATE_MAP));
    }
}
}
