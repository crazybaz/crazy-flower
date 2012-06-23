package {

import flash.display.Sprite;
import flash.display.StageDisplayState;

import mvc.AppContext;

[SWF(width='446', height='322', backgroundColor=0xffffff, frameRate=24)]
public class ClientApp extends Sprite {
    protected var context:AppContext;

    public function ClientApp() {
        stage.displayState = StageDisplayState.NORMAL;
        stage.focus = stage;

        context = new AppContext(this);
    }
}
}
