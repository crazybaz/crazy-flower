/**
 * @author baz
 */
package request {
import flash.geom.Point;

public class PlantRequest extends BaseRequest implements IRequest {

    public var plantType:int;
    public var isoPosition:Point;

    /**
     * Создать запрос на посадку растения
     * @param plantType тип растения
     * @param isoPosition координата посадки
     */
    public function PlantRequest(plantType:int, isoPosition:Point) {
        this.plantType = plantType;
        this.isoPosition = isoPosition;
    }
}
}
