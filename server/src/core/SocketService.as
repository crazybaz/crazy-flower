/**
 * @author baz
 */
package core {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.Socket;

public class SocketService extends EventDispatcher {
    private var socket:Socket;
    private var log:Function;

    public function SocketService(socket:Socket, loggingFunction:Function) {
        this.socket = socket;

        socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
        socket.addEventListener(Event.CLOSE, onClientClose);
        socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);

        log = loggingFunction;
        log("Connected to " + socket.remoteAddress + ":" + socket.remotePort);
    }

    /**
     * Обработчик получения данных
     * @param event
     */
    public function socketDataHandler(event:ProgressEvent):void {
        // Длинна полученного сообщения
        var messageLength:int = socket.readUnsignedInt();

        try {
            if (messageLength <= socket.bytesAvailable) {
                var socketData:String = socket.readUTF();
                log(socket.remoteAddress + ":" + socket.remotePort + " REQUEST " + socketData);
            } else {
                // Сообщение пришло частично
                reply("Partial message: " + socket.bytesAvailable + " of " + messageLength);
            }
        } catch (e:Error) {
            log(e);
        }
    }

    private function reply(message:String):void {
        if (message != null) {
            socket.writeUTFBytes(message);
            socket.flush();
            log(socket.remoteAddress + ":" + socket.remotePort + " RESPONSE " + message);
        }
    }

    private function onClientClose(event:Event):void {
        var socket:Socket = event.target as Socket;
        log("Connection to client " + socket.remoteAddress + ":" + socket.remotePort + " closed.");
        dispatchEvent(new Event(Event.CLOSE));
    }

    private function onIOError(errorEvent:IOErrorEvent):void {
        log("IOError: " + errorEvent.text);
        socket.close();
    }

    public function get closed():Boolean {
        return socket.connected;
    }
}
}