/**
 * @author baz
 */
package request {
public interface IRequest {
    function serialize():String;

    function construct(data:Object):void;
}
}
