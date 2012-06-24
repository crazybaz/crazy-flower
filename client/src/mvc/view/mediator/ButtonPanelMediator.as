/**
 * @author baz
 */
package mvc.view.mediator {
import core.AssetSprite;
import core.PlantType;
import core.ResourceManager;

import event.RequestEvent;

import flash.events.MouseEvent;

import mvc.model.MouseCursor;
import mvc.model.RequestProxy;

import org.robotlegs.mvcs.Mediator;

import ui.ButtonPanel;

public class ButtonPanelMediator extends Mediator {

    [Inject]
    public var view:ButtonPanel;

    [Inject]
    public var requestProxy:RequestProxy;

    [Inject]
    public var mouseCursor:MouseCursor;

    override public function onRegister():void {
        eventMap.mapListener(view.plantCloverBtn, MouseEvent.CLICK, onPlantCloverClick);
        eventMap.mapListener(view.plantPotatoBtn, MouseEvent.CLICK, onPlantPotatoClick);
        eventMap.mapListener(view.plantSunFlowerBtn, MouseEvent.CLICK, onPlantSunFlowerClick);

        eventMap.mapListener(view.collectPlantBtn, MouseEvent.CLICK, onCollectPlantClick);
        eventMap.mapListener(view.levelUpBtn, MouseEvent.CLICK, onLevelUpClick);
    }

    private function onPlantCloverClick(e:MouseEvent):void {
        dispatch(new RequestEvent(RequestEvent.PLANT, PlantType.CLOVER));
        mouseCursor.setIcon(new AssetSprite(ResourceManager.CLOVER_ICON));
    }

    private function onPlantPotatoClick(e:MouseEvent):void {
        dispatch(new RequestEvent(RequestEvent.PLANT, PlantType.POTATO));
        mouseCursor.setIcon(new AssetSprite(ResourceManager.POTATO_ICON));
    }

    private function onPlantSunFlowerClick(e:MouseEvent):void {
        dispatch(new RequestEvent(RequestEvent.PLANT, PlantType.SUNFLOWER));
        mouseCursor.setIcon(new AssetSprite(ResourceManager.SUNFLOWER_ICON));
    }

    /**
     * Послать запрос "Сделать ход"
     */
    private function onLevelUpClick(e:MouseEvent):void {
        requestProxy.sendLevelUpRequest();
        mouseCursor.removeIcon();
    }

    /**
     * Посылаем сообщение о выборе ячейки для сбора растения
     */
    private function onCollectPlantClick(e:MouseEvent):void {
        dispatch(new RequestEvent(RequestEvent.COLLECT));
        mouseCursor.setIcon(new AssetSprite(ResourceManager.SHOVEL_ICON));
    }
}
}
