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

    [SWF(backgroundColor="#000000",frameRate="60")]
    public class CodeBummer extends Sprite{

        public function CodeBummer() {
			
            var game:CodeBummerGame= new CodeBummerGame(0, 600);
			
            CONFIG::mobile
            {
            	if(stage.fullScreenHeight > 480)
                	game.scaleX = game.scaleY = stage.fullScreenHeight / 480;
            }
			
			//ScreenRotation.rotate(game, stage.fullScreenWidth, stage.fullScreenHeight, 2);
			game.rotation = -90;
			//game.y = 
			//game.y += 100;
            addChild(game);
        }
    }
}
