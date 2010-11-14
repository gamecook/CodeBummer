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

            var gameX:int = stage.stageWidth > 480 ? (stage.stageWidth - 480) * .5 : 0;
            var gameY:int = stage.stageHeight > 800 ? (stage.stageHeight - 800) * .5 : 0;

            if( gameX + gameY != 0)
            {
                var bitmap:Bitmap = new BackgroundImage();
                addChild(bitmap);
            }

            var game:CodeBummerGame= new CodeBummerGame(gameX, gameY);

            addChild(game);
        }
    }
}
