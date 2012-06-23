/**
 * @author baz
 */
package core {
import flash.display.DisplayObject;
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

    // Загрузчик
    private static var loader:Loader = new Loader();


    public function ResourceManager() {
    }

    public static function getImage(path:String, onData:Function):void {
        if (assetList[path]) {
            // Берём из кэша
            onData(assetList[path]);
        } else {
            // Загружаем
            loader.load(new URLRequest(path));
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
        }

        // Кэшируем
        function onComplete(e:Event):void {
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
            var image:DisplayObject = loader.content;
            assetList[path] = image;
            onData(image);
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
}
}
