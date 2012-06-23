/**
 * @author baz
 */
package mvc.model.socket {
public interface ISocketHandler {
    function onConnect():void;

    function onData(message:String):void;
}
}
