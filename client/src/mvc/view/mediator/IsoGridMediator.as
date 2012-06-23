/**
 * @author baz
 */
package mvc.view.mediator {
import mvc.model.GridModel;

import org.robotlegs.mvcs.Mediator;

import ui.IsoGrid;

public class IsoGridMediator extends Mediator {

    [Inject]
    public var view:IsoGrid;

    [Inject]
    public var isoGrid:GridModel;

    override public function onRegister():void {
        view.buildLayout();
    }
}
}