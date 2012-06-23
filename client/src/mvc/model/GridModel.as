/**
 * @author baz
 */
package mvc.model {
import flash.utils.Dictionary;

import org.robotlegs.mvcs.Actor;

public class GridModel extends Actor {

    public var cellMap:Dictionary = new Dictionary();
    //public var tileList:Vector.<IsoTile> = Vector.<IsoTile>([]);

    /**
     * Создаём пустую гриду
     */
    public function GridModel() {
        for (var i:int = 0; i < AppSettings.GRID_SIZE; i++) {
            cellMap[i] = new Dictionary();
            for (var j:int = 0; j < AppSettings.GRID_SIZE; j++) {
                //var tile:IsoTile = new IsoTile(i, j);
                //cellMap[i][j] = tile;
                //tileList.push(tile);
            }
        }
    }
}
}
