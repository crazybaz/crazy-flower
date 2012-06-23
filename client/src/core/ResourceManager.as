/**
 * @author baz
 */
package core {
import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;
import flash.utils.Dictionary;

import mx.utils.StringUtil;

public class ResourceManager {
    // Базовые константы путей
    public static const BG:String = "assets/bg.jpg";

    // Шаблоны
    private static const cloverTemplate:String = "assets/clover/{0}.png";
    private static const potatoTemplate:String = "assets/potato/{0}.png";
    private static const sunflowerTemplate:String = "assets/sunflower/{0}.png";

    // Список загруженных ресурсов
    private static var assetList:Dictionary = new Dictionary();

    public function ResourceManager() {
    }

    public static function getImage(path:String, onData:Function):void {
        if (assetList[path]) {
            // Берём из кэша
            var bitmap:Bitmap = assetList[path];
            onData(new Bitmap(bitmap.bitmapData));
        } else {
            // Загружаем
            var loader:Loader = new Loader();
            loader.load(new URLRequest(path));
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
        }

        // Кэшируем
        function onComplete(e:Event):void {
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
            assetList[path] = loader.content;
            onData(assetList[path]);
        }
    }

    /**
     * Вернуть путь для клевера
     * @param id:int
     */
    public static function getCloverPath(id:int):String {
        return StringUtil.substitute(cloverTemplate, id);
    }

    /**
     * Вернуть путь для картофеля
     * @param id:int
     */
    public static function getPotatoPath(id:int):String {
        return StringUtil.substitute(potatoTemplate, id);
    }

    /**
     * Вернуть путь для подсолнуха
     * @param id:int
     */
    public static function getSunFlowerPath(id:int):String {
        return StringUtil.substitute(sunflowerTemplate, id);
    }

    /**
     * Вернуть путь для определённого растения
     */
    public static function getPlantPath(plantType:int, id:int):String {
        var path:String;
        if (plantType == PlantType.CLOVER) {
            path = getCloverPath(id);
        } else if (plantType == PlantType.POTATO) {
            path = getPotatoPath(id);
        } else if (plantType == PlantType.SUNFLOWER) {
            path = getSunFlowerPath(id);
        } else {
            throw new Error("Unknown plant type " + plantType);
        }
        return path;
    }
}
}
