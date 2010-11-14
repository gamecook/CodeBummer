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
{
    import com.gamecook.codebummer.states.StartState;

    import org.flixel.FlxGame;

    public class CodeBummerGame extends FlxGame
    {
        private var defaultX:int = 0;
        private var defaultY:int = 0;
        /**
         * This is the main game constructor.
         */
        public function CodeBummerGame(x:int = 0, y:int = 0)
        {

            this.x = defaultX = x;
            this.y = defaultY = y;

            // Create Flixel Game.
            super(480, 800, StartState, 1);
        }

        override public function showSoundTray(Silent:Boolean = false):void
        {
            //super.showSoundTray(Silent);
        }


        override public function set x(value:Number):void
        {
            super.x = defaultX;
        }

        override public function set y(value:Number):void
        {
            super.y = defaultY;
        }

    }
}
