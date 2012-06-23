/**
 * @author baz
 */
package mvc.view.mediator {
import flash.events.MouseEvent;

import org.robotlegs.mvcs.Mediator;

import ui.ButtonPanel;

public class ButtonPanelMediator extends Mediator {

    [Inject]
    public var view:ButtonPanel;

    override public function onRegister():void {
        eventMap.mapListener(view.plantCloverBtn, MouseEvent.CLICK, onPlantClover);
    }

    private function onPlantClover(e:MouseEvent):void {

    }
}
}
