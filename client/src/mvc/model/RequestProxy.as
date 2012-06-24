/**
 * @author baz
 */
package mvc.model {
import core.SocketConnection;

import flash.geom.Point;

import mvc.model.socket.ISocketHandler;

import request.CollectRequest;
import request.IRequest;
import request.LevelUpRequest;
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
     * Запрос на левелап всех растений
     */
    public function sendLevelUpRequest():void {
        sendRequest(new LevelUpRequest());
    }

    /**
     * Послать запрос на посадку растения
     * @param plantType
     * @param isoPosition
     */
    public function sendPlantRequest(plantType:int, isoPosition:Point):void {
        var plantRequest:PlantRequest = new PlantRequest();
        plantRequest.fill(plantType, isoPosition.x, isoPosition.y);
        sendRequest(plantRequest);
    }

    /**
     * Послать запрос собрать растение
     * @param isoPosition
     */
    public function sendCollectRequest(isoPosition:Point):void {
        var collectRequest:CollectRequest = new CollectRequest();
        collectRequest.fill(isoPosition.x, isoPosition.y);
        sendRequest(collectRequest);
    }

    /**
     * Послать запрос
     * @param request
     */
    public function sendRequest(request:IRequest):void {
        //socketConnection.sendData(request.serialize()); // Ну это пиздец компилятора >>> Call to a possibly undefined method
        socketConnection.sendData(request["serialize"]());
    }

    private function logFunction(msg:String):void {
        trace(">>>", msg);
    }
}
}
