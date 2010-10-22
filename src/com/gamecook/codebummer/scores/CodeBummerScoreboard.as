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

package com.gamecook.codebummer.scores
{
    import com.gamecook.scores.FScoreboard;

    public class CodeBummerScoreboard extends FScoreboard
    {
        public static const ID:String = "CodeBummerScoreboard"
        public static const MAX_SCORES:int = 5;

        public function CodeBummerScoreboard()
        {
            super(ID, MAX_SCORES);

            //TODO need to remove this is just for testing
            //clearScoreboard();

            if (total == 0)
            {
                var defaultScores:Array = [
                    {initials:"BUM", score: 1000},
                    {initials:"Wil", score: 900},
                    {initials:"CDE", score: 500},
                    {initials:"FOR", score: 400},
                    {initials:"FOD", score: 100}
                ];

                scores = defaultScores;
            }

        }
    }
}
