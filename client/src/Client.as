package {

import flash.display.Sprite;
import flash.text.TextField;

public class Client extends Sprite {
    public function Client() {
        var textField:TextField = new TextField();
        textField.text = "Hello, World";
        addChild(textField);
    }
}
}
