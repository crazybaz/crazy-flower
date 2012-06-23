/**
 * @author baz
 */
package request {
public class PlantRequest extends BaseRequest implements IRequest {

    public var isoX:int;
    public var isoY:int;
    public var plantType:int;

    /**
     * Создать запрос на посадку растения
     */
    public function PlantRequest():void {
    }

    /**
     * Заполнить данными
     * @param plantType тип растения
     * @param isoX
     * @param isoY
     */
    public function fill(plantType:int, isoX:int, isoY:int):void {
        this.plantType = plantType;
        this.isoX = isoX;
        this.isoY = isoY;
    }
}
}
