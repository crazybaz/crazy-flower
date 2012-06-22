/**
 * @author baz
 */
package mvc.view.mediator {
import org.robotlegs.mvcs.Mediator;

public class MainViewMediator extends Mediator {

    [Inject]
    public var view:MainView;

    override public function onRegister():void {
        view.buildLayout();

    }
}
}
