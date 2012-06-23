/**
 * @author baz
 */
package event {
import flash.events.Event;

public class RequestEvent extends Event {
    public static const PLANT:String = "PLANT";
    public static const COLLECT:String = "COLLECT";

    private var _plantType:int;

    public function get plantType():int {
        return _plantType;
    }

    public function RequestEvent(type:String, plantType:int = 0) {
        super(type);
        this._plantType = plantType;
    }
}
}
