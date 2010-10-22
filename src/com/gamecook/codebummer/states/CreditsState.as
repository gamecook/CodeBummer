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

    import flash.events.TimerEvent;

    import org.flixel.FlxG;
    import org.flixel.FlxSprite;

    public class CreditsState extends BaseScoreState
    {
        public var clickDelay:int = 50;

        public function CreditsState()
        {
        }


        override public function create():void
        {
            super.create();

            var creditsPhotos:FlxSprite = add(new FlxSprite(0, 330, GameAssets.CreditPhotos)) as FlxSprite;
            creditsPhotos.x = (FlxG.width - creditsPhotos.width) * .5;


            stage.addEventListener(MouseEvent.CLICK, onClick);
            startNextScreenTimer(AboutState, 10);
        }

        private function onClick(event:MouseEvent = null):void
        {
            if (clickDelay <= 0)
            {
                nextScreen = StartState;
                onNextScreen()
            }
        }

        override public function render():void
        {
            if (clickDelay > 0)
                clickDelay -= FlxG.elapsed;

            if (FlxG.keys.justPressed("ENTER"))
                onClick();

            super.render();
        }

        override protected function onNextScreen(event:TimerEvent = null):void
        {
            stage.removeEventListener(MouseEvent.CLICK, onClick);

            super.onNextScreen(event);
        }
    }
}
