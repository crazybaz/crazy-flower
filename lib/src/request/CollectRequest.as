/**
 * @author baz
 */
package request {
public class CollectRequest extends BaseRequest implements IRequest {
    public var isoX:int;
    public var isoY:int;

    public function CollectRequest() {
    }

    /**
     * Заполнить данными
     * @param isoX
     * @param isoY
     */
    public function fill(isoX:int, isoY:int):void {
        this.isoX = isoX;
        this.isoY = isoY;
    }
}
}
