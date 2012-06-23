/**
 * User: silvertoad
 * Date: 11/15/11
 */
package me.silvertoad.nano.core.group.data.event {
import flash.events.Event;

public class NanoItemClickEvent extends Event {

    public static const ITEM_CLICK:String = "ITEM_CLICK";

    public var data:*;

    public function NanoItemClickEvent(type:String, data:*) {
        super(type, true, cancelable);
        this.data = data;
    }
}
}
