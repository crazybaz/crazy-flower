/**
 * @author baz
 */
package mvc.view.mediator {
import org.robotlegs.mvcs.Mediator;

import ui.GridView;

public class GridViewMediator extends Mediator {

    [Inject]
    public var view:GridView;

    override public function onRegister():void {
        view.buildLayout();
    }
}
}