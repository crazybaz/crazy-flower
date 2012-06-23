/**
 * @author baz
 */
package mvc {
import flash.display.Stage;

import mvc.controller.AppStartCmd;
import mvc.model.GridModel;
import mvc.view.mediator.IsoGridMediator;
import mvc.view.mediator.MainViewMediator;

import org.robotlegs.base.ContextEvent;
import org.robotlegs.mvcs.Context;

import ui.IsoGrid;

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
        mediatorMap.mapView(IsoGrid, IsoGridMediator);

        // ============= Синглтоны =============
        injector.mapSingleton(GridModel);

        super.startup();
    }
}
}