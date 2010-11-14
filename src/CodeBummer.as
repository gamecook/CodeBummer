/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 10/9/10
 * Time: 6:37 PM
 * To change this template use File | Settings | File Templates.
 */
package {
    import flash.display.Bitmap;
    import flash.display.Sprite;

    [SWF(width="600",height="1024",backgroundColor="#000000",frameRate="60")]
    public class CodeBummer extends Sprite{

        [Embed(source="../build/assets/CodeBummerTabBackground.jpg")]
        public static var BackgroundImage:Class;

        public function CodeBummer() {

            var game:CodeBummerGame= new CodeBummerGame(0, 0);
            game.scaleX = game.scaleY = stage.stageWidth / 480;

            addChild(game);
        }
    }
}
