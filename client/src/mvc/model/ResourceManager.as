/**
 * @author baz
 */
package mvc.model {
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;
import flash.system.Security;
import flash.utils.Dictionary;

import mx.utils.StringUtil;

public class ResourceManager {
    // Шаблоны
    private var cloverTemplate:String = "assets/clover/{0}.png";
    private var potatoTemplate:String = "assets/potato/{0}.png";
    private var sunflowerTemplate:String = "assets/sunflower/{0}.png";

    // Список загруженных ресурсов
    //private var assetList:Vector.<Bitmap> = Vector.<Bitmap>([]);
    private var assetList:Dictionary;

    // Загрузчик
    private var loader:Loader;

    public function ResourceManager() {
        assetList = new Dictionary();
        loader = new Loader();

        Security.allowDomain("localhost");
    }

    public function getClover(id:int, onData:Function):void {
        var path:String = StringUtil.substitute(cloverTemplate, id);
        if (assetList[path]) {
            // Берём из кэша
            onData(assetList[path]);
        } else {
            // Загружаем
            loader.load(new URLRequest(path));
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (e:Event):void {
                // Кэшируем
                var image:DisplayObject = loader.content;
                assetList[path] = image;
                onData(image);
            });
        }

    }
}
}
