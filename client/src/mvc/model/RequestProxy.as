/**
 * @author baz
 */
package mvc.model {
import core.SocketConnection;

import flash.geom.Point;

import mvc.model.socket.ISocketHandler;

import request.IRequest;
import request.PlantRequest;
import request.SyncRequest;

public class RequestProxy {

    [Inject]
    public var socketHandler:ISocketHandler;

    private var socketConnection:SocketConnection;

    public function RequestProxy() {
    }

    public function init():void {
        // Создаём коннекшн
        socketConnection = new SocketConnection(socketHandler, logFunction);
    }

    /**
     * Запрос синхронизации в ответ на который мы получаем текущие данные по карте
     */
    public function sendSyncRequest():void {
        sendRequest(new SyncRequest());
    }

    /**
     * Послать запрос на посадку растения
     * @param plantType
     * @param isoPosition
     */
    public function sendPlantRequest(plantType:int, isoPosition:Point):void {
        sendRequest(new PlantRequest(plantType, isoPosition));
    }

    /**
     * Послать запрос
     * @param request
     */
    private function sendRequest(request:IRequest):void {
        socketConnection.sendData(request.serialize()); //Ну это пиздец компилятора >>> Call to a possibly undefined method
        socketConnection.sendData(request["serialize"]());
    }

    private function logFunction(msg:String):void {
        trace(">>>", msg);
    }
}
}
