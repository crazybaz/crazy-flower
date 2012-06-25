/**
 * @author baz
 */
package mvc.model.socket {
public interface ISocketHandler {
    function onReady():void;

    function onData(message:String):void;
}
}
