/**
 * @author baz
 */
package mvc.view.mediator {
import flash.events.MouseEvent;

import mvc.model.RequestProxy;

import org.robotlegs.mvcs.Mediator;

import ui.ButtonPanel;

public class ButtonPanelMediator extends Mediator {

    [Inject]
    public var view:ButtonPanel;

    [Inject]
    public var requestProxy:RequestProxy;

    override public function onRegister():void {
        eventMap.mapListener(view.plantCloverBtn, MouseEvent.CLICK, onPlantCloverClick);
        eventMap.mapListener(view.levelUpBtn, MouseEvent.CLICK, onLevelUpClick);
    }

    /**
     * Послать запрос "Сделать ход"
     */
    private function onLevelUpClick(e:MouseEvent):void {
        requestProxy.sendLeveUpRequest();
    }

    private function onPlantCloverClick(e:MouseEvent):void {

    }
}
}
