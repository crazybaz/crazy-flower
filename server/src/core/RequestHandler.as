/**
 * @author baz
 */
package core {
import com.adobe.serialization.json.JSON;

import flash.utils.getDefinitionByName;

import request.CollectRequest;
import request.IRequest;
import request.LevelUpRequest;
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
            onSync();
        } else if (request is LevelUpRequest) {
            onLevelUp();
        } else if (request is PlantRequest) {
            onPlant(PlantRequest(request));
        } else if (request is CollectRequest) {
            onCollect(CollectRequest(request));
        }
    }

    /**
     * Синхронизация, клиенту возвращается актуальное состояние игры
     */
    private function onSync():void {
        if (socket.isClosed == false) {
            socket.response(db.getSerializedData());
        }
    }

    /**
     * Вырастить
     */
    private function onLevelUp():void {
        db.levelUp();
        onSync();
    }

    /**
     * Посадить растение
     */
    private function onPlant(request:PlantRequest):void {
        //db.plant(request.plantType, request.isoX, request.isoY);
        db.plant(request["plantType"], request["isoX"], request["isoY"]);
        onSync();
    }

    /**
     * Собрать растение
     */
    private function onCollect(request:CollectRequest):void {
        //db.collect(request.isoX, request.isoY);
        db.collect(request["isoX"], request["isoY"]);
        onSync();
    }
}
}
