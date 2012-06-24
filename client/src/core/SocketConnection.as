/**
 * @author baz
 */
package core {
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.events.TimerEvent;
import flash.net.Socket;
import flash.utils.ByteArray;
import flash.utils.Timer;

import mvc.model.socket.ISocketHandler;

public class SocketConnection {
    private var socket:Socket;
    private var retryTimer:Timer = new Timer(1000);
    private var log:Function;

    private var handler:ISocketHandler;

    public function SocketConnection(handler:ISocketHandler, loggingFunction:Function) {
        log = loggingFunction;
        this.handler = handler;

        // Создаём сокет и слушателей
        socket = new Socket();
        socket.addEventListener(Event.CONNECT, onConnect);
        socket.addEventListener(Event.CLOSE, onConnectionClose);
        socket.addEventListener(IOErrorEvent.IO_ERROR, onSocketError);
        socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        socket.addEventListener(ProgressEvent.SOCKET_DATA, onDataReceived);

        // Коннектимся
        retryTimer.addEventListener(TimerEvent.TIMER, connect);
        retryTimer.start();
    }

    /**
     * Присоединяемся к сокету
     */
    private function connect(event:TimerEvent):void {
        try {
            socket.connect(AppSettings.APP_HOST, AppSettings.APP_PORT);
        } catch (e:Error) {
            log(e.toString());
        }
    }

    /**
     * Соединение установлено
     */
    private function onConnect(event:Event):void {
        retryTimer.removeEventListener(TimerEvent.TIMER, connect);
        retryTimer.stop();
        handler.onConnect();
    }

    /**
     * Данные
     */
    private function onDataReceived(event:ProgressEvent):void {
        try {
            // Может прийти несколько сообщений
            while (socket.bytesAvailable) {
                var bytesAvailable:uint = socket.bytesAvailable;
                // Длинна сообщения
                var messageLength:uint = socket.readUnsignedInt();

                if (messageLength <= bytesAvailable) {
                    var message:String = socket.readUTF();
                    handler.onData(message);
                    log("Received: " + message);
                } else {
                    // Сообщение пришло частично
                    log("Partial message: " + bytesAvailable + " of " + messageLength);
                }
            }
        } catch (e:Error) {
            log(e.toString());
        }
    }

    /**
     * Послать запрос
     */
    public function sendData(msg:String):void {
        var bytes:ByteArray = new ByteArray();
        bytes.writeObject(msg);
        bytes.position = 0;

        socket.writeUnsignedInt(bytes.length);
        socket.writeUTF(msg);
        socket.flush();

        log("Sending request: " + msg);
    }

    private function onConnectionClose(event:Event):void {
        log("Connection closed by server");
    }

    private function onSocketError(error:IOErrorEvent):void {
        log(error.text);
    }

    private function onSecurityError(event:SecurityErrorEvent):void {
        log(event.text);
    }
}
}