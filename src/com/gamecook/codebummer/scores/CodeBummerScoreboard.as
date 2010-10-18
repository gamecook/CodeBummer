/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 10/14/10
 * Time: 8:04 AM
 * To change this template use File | Settings | File Templates.
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
