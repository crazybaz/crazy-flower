/**
 * @author baz
 */
package core {
import com.adobe.serialization.json.JSON;

import flash.utils.getDefinitionByName;

import request.IRequest;
import request.PlantRequest;
import request.SyncRequest;

public class RequestHandler {
    private var db:DataBase;
    public var socket:SocketService;

    public function RequestHandler(db:DataBase) {
        this.db = db;
    }

    /**
     * Обработать запрос клиента
     * @param msg
     */
    public function process(msg:String):void {
        var socketData:Object = JSON.decode(msg);
        var requestClass:Class = getDefinitionByName(socketData["clazz"]) as Class;

        var request:IRequest = new requestClass();
        //request.construct(socketData["params"]);
        request["construct"](socketData["params"]);

        if (request is SyncRequest) {
            makeSync();
        } else if (request is PlantRequest) {
            makePlant(PlantRequest(request));
        } else {
            socket.log("Request not recognized " + socketData["clazz"]);
        }
    }

    /**
     * Синхронизация, клиенту возвращается актуальное состояние игры
     */
    private function makeSync():void {
        if (socket.isClosed == false) {
            socket.response(db.getSerializedData());
        }
    }

    /**
     * Посадить растение
     */
    private function makePlant(request:PlantRequest):void {
        //db.plant(request.plantType, request.isoPosition);
    }
}
}
