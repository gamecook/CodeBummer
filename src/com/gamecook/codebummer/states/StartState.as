/*
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package
com.gamecook.codebummer.states
{
    import com.gamecook.codebummer.sprites.GameAssets;
    import com.gamecook.scores.FScoreboard;

    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import org.flixel.FlxG;
    import org.flixel.FlxSprite;
    import org.flixel.FlxText;

    public class StartState extends BaseState
    {
        private var scoreBoard:FScoreboard;
        private var flickerTime:int = 0;
        private const FLICKER_DELAY:int = 100;

        private var storyXML:XML = <story>It was a dark time for Flash developers. The evil Apple empire almost exterminated them all. And out of the ashes rose a new type of interactive developer, one who was not afraid to learn multiple languages and explore different platforms. This developer’s name was Code Bum.

        Code Bum wanders the streets of New York City looking for new clients to help expand his programming knowledge. This is his story...
        </story>;

        private var activateText:FlxText;
        private var timer:Timer;


        /**
         * This is the first game state the player sees. Simply lets them click anywhere to start.
         */
        public function StartState()
        {
            super();
        }

        /**
         * Goes through and creates the graphics needed to display the start message
         */
        override public function create():void
        {
            super.create();

            timer = new Timer(500, 1);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
            timer.start();

            var title:FlxSprite = new FlxSprite(0, 120, GameAssets.TitleSprite);
            title.x = (FlxG.width - title.width) * .5;
            add(title);

            add(new FlxText(40, 360, 400, storyXML.toString()).setFormat(null, 18, 0xffffff, "center"));

            flickerTime = FLICKER_DELAY;
        }

        private function onTimerComplete(event:TimerEvent):void
        {
            event.target.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);

            stage.addEventListener(MouseEvent.CLICK, onClick);

            activateText = add(new FlxText(0, 270, FlxG.width, "PRESS ENTER TO START").setFormat(null, 24, 0xFFFFFFFF, "center")) as FlxText;

            CONFIG::mobile
            {
                activateText.text = "PRESS ANYWHERE TO START";
            }

            startNextScreenTimer(CreditsState);

        }

        /**
         * Handles when the user clicks and changes to the PlayState.
         * @param event MouseEvent
         */
        private function onClick(event:MouseEvent = null):void
        {
            timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
            timer.stop();
            killNextScreenTimer();
            FlxG.level = 0;
            FlxG.score = 0;
            // Sound is played after the state switch to keep it from being destroyed

            FlxG.state = new PlayState();

            FlxG.play(GameAssets.ThemeSound);
        }

        /**
         * This removed the click listener.
         */
        override public function destroy():void
        {
            stage.removeEventListener(MouseEvent.CLICK, onClick);
            super.destroy();
        }

        override public function render():void
        {
            if (FlxG.keys.justPressed("ENTER"))
                onClick();

            flickerTime -= FlxG.elapsed;
            if (flickerTime <= 0)
            {
                activateText.visible = !activateText.visible;
                flickerTime = FLICKER_DELAY;
            }

            super.render();
        }


    }
}