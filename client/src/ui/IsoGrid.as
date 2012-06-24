/**
 * @author baz
 */
package ui {
import core.AssetSprite;
import core.Cell;
import core.ResourceManager;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.utils.Dictionary;

public class IsoGrid extends Sprite {

    // Слои для графики
    public var plantLayer:DisplayObjectContainer;
    public var cellLayer:DisplayObjectContainer;
    public var dragLayer:DisplayObjectContainer;

    // Массивы
    private var plantMap:Dictionary;
    private var cellMap:Dictionary;


    public function IsoGrid() {
        plantMap = new Dictionary();
        cellMap = new Dictionary();
    }

    public function getPlantTile(i:int, j:int):PlantTile {
        var tile:PlantTile;
        plantMap[i] && (tile = plantMap[i][j]);
        return tile;
    }

    public function getCellTile(i:int, j:int):CellTile {
        var tile:CellTile;
        cellMap[i] && (tile = cellMap[i][j]);
        return tile;
    }

    /**
     * Собрать карту
     */
    public function buildLayout():void {
        // Подложка
        var bg:AssetSprite = new AssetSprite(ResourceManager.BG);
        addChild(bg);

        // Заполняем
        plantLayer = new Sprite();
        cellLayer = new Sprite();
        dragLayer = new Sprite();

        for (var i:int = 0; i < AppSettings.GRID_SIZE; i++) {
            plantMap[i] = new Dictionary();
            cellMap[i] = new Dictionary();
            for (var j:int = 0; j < AppSettings.GRID_SIZE; j++) {
                var plantTile:PlantTile = new PlantTile(i, j);
                plantMap[i][j] = plantTile;
                plantLayer.addChild(plantTile);

                var cellTie:CellTile = new CellTile(i, j);
                cellMap[i][j] = cellTie;
                cellLayer.addChild(cellTie);
            }
        }

        addChild(plantLayer);
        addChild(dragLayer);
        addChild(cellLayer);

        // Позиционируем по bg
        plantLayer.x = cellLayer.x = dragLayer.x = 742;
        plantLayer.y = cellLayer.y = dragLayer.y = 97;

        // Красивое позиционирование
        this.x = -465;
        this.y = -60;
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
                    getPlantTile(i, j).update(cell);
                    cell.isUpdated = false;
                }
            }
        }
    }

    private var selectedCell:CellTile;

    /**
     * Подсветить выбранную ячейку
     */
    public function selectCell(i:int, j:int):void {
        selectedCell && selectedCell.cleanCellView();
        selectedCell = getCellTile(i, j);
        selectedCell && selectedCell.drawCellView();
    }
}
}
