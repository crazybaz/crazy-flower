/**
 * User: silvertoad
 * Date: 11/14/11
 */
package me.silvertoad.nano.test {
import flash.events.MouseEvent;

import me.silvertoad.nano.core.group.NanoGroup;
import me.silvertoad.nano.core.group.data.NanoDataGroup;
import me.silvertoad.nano.core.group.layout.NanoHorizontalLayout;
import me.silvertoad.nano.core.group.layout.NanoVerticalLayout;
import me.silvertoad.nano.core.group.layout.align.NanoHorizontalAlign;
import me.silvertoad.nano.core.group.layout.align.NanoVerticalAlign;
import me.silvertoad.nano.core.text.NanoTextField;
import me.silvertoad.nano.core.view.NanoViewStack;
import me.silvertoad.nano.quick.button.QuickNanoButton;

public class Test extends NanoGroup {
    public function Test() {
        super(new NanoHorizontalLayout());

        // демонстрация работы NanoGroup
        var firstGroup:NanoGroup = new NanoGroup(new NanoVerticalLayout());
        firstGroup.add(new NanoTextField().suText("NanoGroup test:"));
        firstGroup.add(new NanoTextField().suText("base layout"))
                .add(
                new NanoGroup()
                        .add(TestShape.getRect())
                        .add(TestShape.getRect())
                        .add(TestShape.getRect())
                        .suHeight(50)
                        .build());
        firstGroup.add(new NanoTextField().suText("horizontal layout"))
                .add(
                new NanoGroup(new NanoHorizontalLayout())
                        .add(TestShape.getRect())
                        .add(TestShape.getRect())
                        .add(TestShape.getRect())
                        .suVAlign(NanoVerticalAlign.TOP)
                        .suHeight(50)
                        .build());
        firstGroup.add(new NanoTextField().suText("vertical layout"))
                .add(
                new NanoGroup(new NanoVerticalLayout())
                        .add(TestShape.getRect())
                        .add(TestShape.getRect())
                        .add(TestShape.getRect())
                        .suHAlign(NanoHorizontalAlign.LEFT)
                        .suVAlign(NanoVerticalAlign.TOP)
                        .suHeight(150)
                        .build());

        // демонстрация работы NanoDataGroup
        var secondGroup:NanoGroup = new NanoGroup(new NanoVerticalLayout());
        secondGroup.add(new NanoTextField().suText("NanoDataGroup test:"));
        secondGroup.add(new NanoTextField().suText("base layout"))
                .add(
                new NanoDataGroup()
                        .suItemRenderer(TestItemRenderer)
                        .suDataProvider([1, 2, 3])
                        .suHeight(50)
                        .build());
        secondGroup.add(new NanoTextField().suText("horizontal layout"))
                .add(
                new NanoDataGroup(new NanoHorizontalLayout())
                        .suItemRenderer(TestItemRenderer)
                        .suDataProvider([1, 2, 3])
                        .suHAlign(NanoHorizontalAlign.LEFT)
                        .suVAlign(NanoVerticalAlign.BOTTOM)
                        .suHeight(50)
                        .build());
        secondGroup.add(new NanoTextField().suText("vertical layout"))
                .add(
                new NanoDataGroup(new NanoVerticalLayout())
                        .suItemRenderer(TestItemRenderer)
                        .suDataProvider([1, 2, 3])
                        .suHAlign(NanoHorizontalAlign.RIGHT)
                        .suVAlign(NanoVerticalAlign.TOP)
                        .suHeight(150)
                        .build());

        var nanoQuickButton:QuickNanoButton = new QuickNanoButton();
        add(nanoQuickButton.suLabel("Next"));
        nanoQuickButton.addEventListener(MouseEvent.CLICK, itemClickHandler);

        nanoViewStack = new NanoViewStack();
        add(nanoViewStack
                .suAddPage(firstGroup.suWidth(150).build())
                .suAddPage(secondGroup.suWidth(150).build())
                .suWidth(250).build());

        suPadLeft(20).suPadTop(20).suVAlign(NanoVerticalAlign.TOP).build();
    }

    private var nanoViewStack:NanoViewStack;

    private function itemClickHandler(event:MouseEvent):void {
        var nextIndex:int = (nanoViewStack.selectedIndex + 1);
        if (nanoViewStack.numPages <= nextIndex) {
            nextIndex = 0;
        }
        nanoViewStack.selectedIndex = nextIndex;
    }
}
}