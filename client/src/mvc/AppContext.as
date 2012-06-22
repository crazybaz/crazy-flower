/**
 * @author baz
 */
package mvc {
import flash.display.Stage;

import mvc.controller.AppStartCmd;
import mvc.view.mediator.MainViewMediator;

import org.robotlegs.base.ContextEvent;
import org.robotlegs.mvcs.Context;

public class AppContext extends Context {
    private var stage:Stage;

    public function AppContext(appMain:ClientApp) {
        stage = appMain.stage;
        super(appMain);
    }

    override public function startup():void {
        // ============= События =============
        commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, AppStartCmd, ContextEvent, true);

        // ============= Переменные =============
        injector.mapValue(Stage, stage);

        // ============= Медиаторы =============
        mediatorMap.mapView(MainView, MainViewMediator);

        // ============= Синглтоны =============
        //injector.mapSingleton(GameModel);

        super.startup();
    }
}
}