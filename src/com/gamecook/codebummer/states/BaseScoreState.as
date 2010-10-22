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
    import com.gamecook.codebummer.scores.CodeBummerScoreboard;

    import org.flixel.FlxG;
    import org.flixel.FlxText;

    public class BaseScoreState extends BaseState
    {
        private var scores:Array;
        private var textItem:FlxText;

        public function BaseScoreState()
        {
            super();
        }


        override public function create():void
        {
            super.create();

            textItem = new FlxText(0, FlxG.height / 6, FlxG.width, "SCORE RANKING");
            textItem.setFormat(null, 15, 0xd8d94a, "center", 0);
            add(textItem);

            scores = scoreboard.scores;
            var xpos:Number;
            var i:int;
            var totalScores:int = CodeBummerScoreboard.MAX_SCORES;
            var ypos:int = textItem.bottom + 20;

            //second loop lay out the current high scores.
            for (i = 0; i < totalScores; i++)
            {
                var scoreObj:Object = scores[i];
                //display the current score.
                //index


                var color:uint = (scoreObj.score == FlxG.score) ? 0xc83fbb : 0xffffff;

                textItem = new FlxText(140, ypos, 25, (i + 1).toString());
                textItem.setFormat(null, 15, color, "left", 0);
                add(textItem);

                xpos = textItem.left + 30;

                //initials - loop to position each separately.
                for (var j:Number = 0; j < 3; j++)
                {

                    textItem = new FlxText(xpos, ypos, 15, scoreObj.initials.charAt(j));
                    //new high score text gets colored red.
                    textItem.setFormat(null, 15, color, "center", 0);
                    add(textItem);

                    xpos += 20;
                }

                //score
                textItem = new FlxText(xpos, ypos, 100, scoreObj.score.toString());
                textItem.setFormat(null, 15, color, "right", 0);
                add(textItem);

                ypos += 20;

            }

        }
    }
}
