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

package com.gamecook.codebummer.states
{
    import com.gamecook.codebummer.sprites.GameAssets;

    import flash.events.MouseEvent;

    import flash.events.TimerEvent;

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
            startNextScreenTimer(StartState, 20);
        }

        private function onClick(event:MouseEvent = null):void
        {
            nextScreen = StartState;
            onNextScreen()
        }

        override public function render():void
        {
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
