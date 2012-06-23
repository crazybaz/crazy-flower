/**
 * User: silvertoad
 * Date: 11/15/11
 */
package me.silvertoad.nano.core.text {
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class NanoTextField extends TextField {
    public function NanoTextField() {
        autoSize = TextFieldAutoSize.LEFT;
    }

    // ---------- syntactic sugar ----------

    public function suText(text:String):NanoTextField {
        this.text = text;
        mouseEnabled = false;
        return this;
    }

    public function suFormat(tf:TextFormat):NanoTextField {
        this.defaultTextFormat = tf;
        suText(text);
        return this;
    }
}
}
