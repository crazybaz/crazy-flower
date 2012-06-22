package {

import flash.display.Sprite;
import flash.display.StageDisplayState;

import mvc.AppContext;

[SWF(width='760', height='760', backgroundColor=0xffffff, frameRate=24)]
public class ClientApp extends Sprite {
    protected var context:AppContext;

    public function ClientApp() {
        stage.displayState = StageDisplayState.NORMAL;
        stage.focus = stage;

        context = new AppContext(this);
    }
}
}
