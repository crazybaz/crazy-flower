/**
 * @author baz
 */
package request {
import flash.utils.getQualifiedClassName;

public class BaseRequest {
    /**
     * Сериализация класса
     */
    public function serialize():String {
        return JSON.stringify({clazz:getQualifiedClassName(this), params:this});
    }

    /**
     * Заполнить данные класса из полученного объекта
     */
    public function construct(data:Object):void {
        for (var key:String in data) {
            this[key] = data[key];
        }
    }
}
}
