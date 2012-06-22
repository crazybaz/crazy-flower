/**
 * @author baz
 */
package mvc.view.mediator {
import mvc.model.ResourceManager;

import org.robotlegs.mvcs.Mediator;

public class MainViewMediator extends Mediator {

    [Inject]
    public var view:MainView;

    [Inject]
    public var rm:ResourceManager;

    override public function onRegister():void {
        view.buildLayout(rm);
    }
}
}
