package {

import flash.display.Sprite;
import flash.display.StageDisplayState;
import flash.system.Security;

import mvc.AppContext;

[SWF(width='550', height='400', backgroundColor=0xffffff, frameRate=24)]
public class ClientApp extends Sprite {
    protected var context:AppContext;

    public function ClientApp() {
        Security.allowDomain("*");

        stage.displayState = StageDisplayState.NORMAL;
        stage.focus = stage;

        context = new AppContext(this);
    }
}
}
