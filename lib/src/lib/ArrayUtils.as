/**
 * @author baz
 */
package lib {
public class ArrayUtils {
    /**
     * Выбрать рандомное значение в массиве и вернуть его
     */
    public static function getRandomItem(arr:Array):* {
        var idx:int = Math.floor(Math.random() * arr.length);
        return arr[idx];
    }

}
}
