/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 10/17/10
 * Time: 2:41 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.codebummer.states
{
    import com.gamecook.codebummer.sprites.GameAssets;

    import flash.events.MouseEvent;

    import org.flixel.FlxG;
    import org.flixel.FlxSprite;

    public class AboutState extends BaseScoreState
    {

        public function AboutState()
        {
        }


        override public function create():void
        {
            super.create();

            var creditsPhotos:FlxSprite = add(new FlxSprite(0, 350, GameAssets.About)) as FlxSprite;
            creditsPhotos.x = (FlxG.width - creditsPhotos.width) * .5;

            stage.addEventListener(MouseEvent.CLICK, onClick);
            startNextScreenTimer(StartState, 20000);
        }

        private function onClick(event:MouseEvent = null):void
        {
            killNextScreenTimer();
            FlxG.state = new StartState();
        }

        override public function render():void
        {
            if (FlxG.keys.justPressed("ENTER"))
                onClick();

            super.render();
        }

        override protected function killNextScreenTimer():void
        {
            stage.removeEventListener(MouseEvent.CLICK, onClick);
            super.killNextScreenTimer();
        }
    }
}
