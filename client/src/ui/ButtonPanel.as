/**
 * @author baz
 */
package ui {
import flash.display.Sprite;

import me.silvertoad.nano.core.group.NanoGroup;
import me.silvertoad.nano.core.group.layout.NanoVerticalLayout;
import me.silvertoad.nano.quick.button.QuickNanoButton;

public class ButtonPanel extends Sprite {
    // Кнопки
    public var plantCloverBtn:QuickNanoButton;
    public var plantPotatoBtn:QuickNanoButton;
    public var plantSunFlowerBtn:QuickNanoButton;

    public var collectPlantBtn:QuickNanoButton;
    public var levelUpBtn:QuickNanoButton;

    public function ButtonPanel() {
        // Основная группа
        var mainGroup:NanoGroup = new NanoGroup(new NanoVerticalLayout(2));

        // Создаём кнопки
        plantCloverBtn = new QuickNanoButton();
        plantCloverBtn.suLabel("Посадить клевер");
        plantPotatoBtn = new QuickNanoButton();
        plantPotatoBtn.suLabel("Посадить картофель");
        plantSunFlowerBtn = new QuickNanoButton();
        plantSunFlowerBtn.suLabel("Посадить подсолнух");

        collectPlantBtn = new QuickNanoButton();
        collectPlantBtn.suLabel("Собрать растение");

        levelUpBtn = new QuickNanoButton();
        levelUpBtn.suLabel("Сделать ход");

        mainGroup
                .add(plantCloverBtn)
                .add(plantPotatoBtn)
                .add(plantSunFlowerBtn)
                .add(collectPlantBtn)
                .add(levelUpBtn);
        mainGroup.build();
        addChild(mainGroup);
    }
}
}
