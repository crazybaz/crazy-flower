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
        var serializeData:Object = {};
        serializeData[getQualifiedClassName(this)] = this;
        return JSON.stringify(serializeData);
    }
}
}
