/**
 * @author baz
 */
package request {

public class MoveRequest extends BaseRequest implements IRequest {
    public var curIsoX:int;
    public var curIsoY:int;

    public var newIsoX:int;
    public var newIsoY:int;

    public function MoveRequest() {
    }

    public function fill(curIsoX:int, curIsoY:int, newIsoX:int, newIsoY:int):void {
        this.curIsoX = curIsoX;
        this.curIsoY = curIsoY;

        this.newIsoX = newIsoX;
        this.newIsoY = newIsoY;
    }
}
}
