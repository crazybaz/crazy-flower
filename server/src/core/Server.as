/**
 * @author baz
 */
package core {
import flash.events.Event;
import flash.events.ServerSocketConnectEvent;
import flash.net.ServerSocket;

public class Server {
    private var serverSocket:ServerSocket;
    private var clientSockets:Array = new Array();
    private var log:Function;

    public function Server(loggingFunction:Function) {
        log = loggingFunction;
        serverSocket = new ServerSocket();

        // Слушатели
        serverSocket.addEventListener(Event.CONNECT, onConnect);
        serverSocket.addEventListener(Event.CLOSE, onClose);

        // Биндимся
        serverSocket.bind(AppSettings.APP_PORT, AppSettings.APP_HOST);

        // Прослушиваем
        serverSocket.listen();

        // Логируем старт
        log("Listening on " + serverSocket.localPort);
    }

    /**
     * Соединение с клиентом
     * @param event
     */
    public function onConnect(event:ServerSocketConnectEvent):void {
        // Читаем или создаём базу данных для клиента
        var db:DataBase = new DataBase(event.socket.localAddress);

        // Делегируем сервису
        var socketService:SocketService = new SocketService(event.socket, new RequestHandler(db), log);
        socketService.addEventListener(Event.CLOSE, onClientClose);

        // Сохраняем
        clientSockets.push(socketService);
    }

    /**
     * Соединение закрылось с клиентом
     * @param event
     */
    private function onClientClose(event:Event):void {
        for each(var socketService:SocketService in clientSockets) {
            if (socketService.isClosed) {
                socketService = null;
            }
        }
    }

    private function onClose(event:Event):void {
        log("Server socket closed");
    }
}
}