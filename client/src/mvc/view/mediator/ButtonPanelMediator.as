/**
 * @author baz
 */
package mvc.view.mediator {
import core.PlantType;

import event.RequestEvent;

import flash.events.MouseEvent;

import mvc.model.RequestProxy;

import org.robotlegs.mvcs.Mediator;

import ui.ButtonPanel;

public class ButtonPanelMediator extends Mediator {

    [Inject]
    public var view:ButtonPanel;

    [Inject]
    public var requestProxy:RequestProxy;

    private var plantType:int;

    override public function onRegister():void {
        eventMap.mapListener(view.plantCloverBtn, MouseEvent.CLICK, onPlantCloverClick);
        eventMap.mapListener(view.plantPotatoBtn, MouseEvent.CLICK, onPlantPotatoClick);
        eventMap.mapListener(view.plantSunFlowerBtn, MouseEvent.CLICK, onPlantSunFlowerClick);

        eventMap.mapListener(view.collectPlantBtn, MouseEvent.CLICK, onCollectPlantClick);
        eventMap.mapListener(view.levelUpBtn, MouseEvent.CLICK, onLevelUpClick);
    }

    private function onPlantCloverClick(e:MouseEvent):void {
        dispatch(new RequestEvent(RequestEvent.PLANT, PlantType.CLOVER));
    }

    private function onPlantPotatoClick(e:MouseEvent):void {
        dispatch(new RequestEvent(RequestEvent.PLANT, PlantType.POTATO));
    }

    private function onPlantSunFlowerClick(e:MouseEvent):void {
        dispatch(new RequestEvent(RequestEvent.PLANT, PlantType.SUNFLOWER));
    }

    /**
     * Послать запрос "Сделать ход"
     */
    private function onLevelUpClick(e:MouseEvent):void {
        requestProxy.sendLevelUpRequest();
    }

    /**
     * Посылаем сообщение о выборе ячейки для сбора растения
     */
    private function onCollectPlantClick(e:MouseEvent):void {
        dispatch(new RequestEvent(RequestEvent.COLLECT));
    }
}
}
