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

        socket.addEventListener(ProgressEvent.SOCKET_DATA, handshake);
        socket.addEventListener(Event.CLOSE, onClientClose);
        socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);

        log = loggingFunction;
        log("Connected to " + socket.remoteAddress + ":" + socket.remotePort);
    }

    /**
     * Обработать запрос на политику
     * @param event
     */
    private function handshake(event:ProgressEvent):void {
        var socket:Socket = event.target as Socket;
        var socketData:String = socket.readUTFBytes(socket.bytesAvailable);
        if (socketData == "<policy-file-request/>") {
            var policy:String = '<cross-domain-policy><allow-access-from domain="*" to-ports="*" /></cross-domain-policy>\x00';
            socket.writeUTFBytes(policy);
            socket.flush();
            socket.close();
            log(">> POLICY " + policy);
        } else if (socketData == "BEGIN") {
            socket.removeEventListener(ProgressEvent.SOCKET_DATA, handshake);
            socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
            log(">> REQUEST " + socketData);
            response("READY");
        }
    }

    /**
     * Обработчик получения данных
     * @param event
     */
    private function onSocketData(event:ProgressEvent):void {
        try {
            // Может прийти несколько сообщений
            while (socket.bytesAvailable) {
                var bytesAvailable:uint = socket.bytesAvailable;
                // Длинна сообщения
                var messageLength:uint = socket.readUnsignedInt();

                if (messageLength <= bytesAvailable) {
                    var message:String = socket.readUTF();
                    log(socket.remoteAddress + ":" + socket.remotePort + " >> REQUEST " + message);
                    handler.process(message);
                } else {
                    // Сообщение пришло частично
                    log("Partial message: " + bytesAvailable + " of " + messageLength);
                }
            }
        } catch (e:Error) {
            log(e);
        }
    }

    /**
     * Обработка полученных данных
     * @param socketData
     */
    private function process(socketData:String):void {
        log(socket.remoteAddress + ":" + socket.remotePort + " >> REQUEST " + socketData);
        handler.process(socketData);
    }

    /**
     * Послать ответ клиенту
     * @param msg
     */
    public function response(msg:String):void {
        var bytes:ByteArray = new ByteArray();
        bytes.writeObject(msg);
        bytes.position = 0;

        socket.writeUnsignedInt(bytes.length);
        socket.writeUTF(msg);
        socket.flush();

        log(socket.remoteAddress + ":" + socket.remotePort + " >> RESPONSE " + msg);
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