/**
 * @author baz
 */
package core {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.Socket;
import flash.utils.ByteArray;

public class SocketService extends EventDispatcher {
    public var log:Function;

    private var socket:Socket;
    private var handler:RequestHandler;

    public function SocketService(socket:Socket, handler:RequestHandler, loggingFunction:Function) {
        this.socket = socket;
        this.handler = handler;
        handler.socket = this;

        socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
        socket.addEventListener(Event.CLOSE, onClientClose);
        socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);

        log = loggingFunction;
        log("Connected to " + socket.remoteAddress + ":" + socket.remotePort);
    }

    /**
     * Обработчик получения данных
     * @param event
     */
    private function onSocketData(event:ProgressEvent):void {
        // Длинна полученного сообщения
        var messageLength:int = socket.readUnsignedInt();

        try {
            if (messageLength <= socket.bytesAvailable) {
                var socketData:String = socket.readUTF();
                log(socket.remoteAddress + ":" + socket.remotePort + " >>> REQUEST " + socketData);
                handler.process(socketData);
            } else {
                // Сообщение пришло частично
                log("Partial message: " + socket.bytesAvailable + " of " + messageLength);
            }
        } catch (e:Error) {
            log(e);
        }
    }

    /**
     * Послать ответ клиенту
     * @param msg
     */
    public function response(msg:String):void {
        if (msg != null) {
            var bytes:ByteArray = new ByteArray();
            bytes.writeObject(msg);
            bytes.position = 0;

            socket.writeUnsignedInt(bytes.length);
            socket.writeUTF(msg);
            socket.flush();

            log(socket.remoteAddress + ":" + socket.remotePort + " RESPONSE " + msg);
        }
    }

    private function onClientClose(event:Event):void {
        log("Connection to client " + socket.remoteAddress + ":" + socket.remotePort + " closed");
        dispatchEvent(new Event(Event.CLOSE));
    }

    private function onIOError(errorEvent:IOErrorEvent):void {
        log("IOError: " + errorEvent.text);
        socket.close();
    }

    public function get isClosed():Boolean {
        return !socket.connected;
    }
}
}