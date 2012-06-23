/**
 * @author baz
 */
package ui {
import core.AssetSprite;
import core.Cell;
import core.ResourceManager;

import flash.display.Sprite;
import flash.utils.Dictionary;

public class IsoGrid extends Sprite {

    private var tileMap:Dictionary;

    public function IsoGrid() {
        tileMap = new Dictionary();
    }

    public function getTile(i:int, j:int):IsoTile {
        var tile:IsoTile;
        tileMap[i] && (tile = tileMap[i][j]);
        return tile;
    }

    public function buildLayout():void {
        // Подложка
        var bg:AssetSprite = new AssetSprite(ResourceManager.BG);
        addChild(bg);
        bg.x = -742;
        bg.y -= 97;

        // Собрать и отрисовать карту
        var gridLayer:Sprite = new Sprite();

        for (var i:int = 0; i < AppSettings.GRID_SIZE; i++) {
            tileMap[i] = new Dictionary();
            for (var j:int = 0; j < AppSettings.GRID_SIZE; j++) {
                var tile:IsoTile = new IsoTile(i, j);
                tileMap[i][j] = tile;
                gridLayer.addChild(tile);
            }
        }
        addChild(gridLayer);
    }

    /**
     * Обновить отображение
     */
    public function update(cellMap:Dictionary):void {
        for (var i:int = 0; i < AppSettings.GRID_SIZE; i++) {
            for (var j:int = 0; j < AppSettings.GRID_SIZE; j++) {
                var cell:Cell = Cell(cellMap[i][j]);
                // Обновляем только есть требуется
                if (cell.isUpdated) {
                    getTile(i, j).update(cell);
                    cell.isUpdated = false;
                }
            }
        }
    }

    private var selectedCell:IsoTile;

    /**
     * Подсветить выбранную ячейку
     */
    public function selectCell(i:int, j:int):void {
        selectedCell && selectedCell.cleanCellView();
        selectedCell = getTile(i, j);
        selectedCell && selectedCell.drawCellView();
    }
}
}
