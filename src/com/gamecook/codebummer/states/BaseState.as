/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 10/14/10
 * Time: 8:03 AM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.codebummer.states
{
    import com.gamecook.codebummer.scores.CodeBummerScoreboard;
    import com.gamecook.codebummer.sprites.GameAssets;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import org.flixel.FlxG;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
    import org.flixel.FlxText;

    public class BaseState extends FlxState
    {
        protected var scoreboard:CodeBummerScoreboard;
        protected var scoreTxt:FlxText;
        protected var nextScreen:Class;
        protected var nextScreenTimer:Timer;

        public function BaseState()
        {
            super();
        }

        override public function create():void
        {
            super.create();

            scoreboard = new CodeBummerScoreboard();

            var sprite:FlxSprite = new FlxSprite(0, 80);
            sprite.createGraphic(FlxG.width, 240, 0xff003366);
            add(sprite);

            sprite = new FlxSprite(0, 0, GameAssets.Skyline);
            add(sprite);

            // Create Text for title, credits, and score

            var demoTXT:FlxText = add(new FlxText((FlxG.width - 200) * .5, 0, 200, "HI-SCORE").setFormat(null, 18, 0xffffff, "center")) as FlxText;
            var highScore:FlxText = add(new FlxText(demoTXT.x, demoTXT.y + demoTXT.height, 200, scoreboard.getScore(0).score).setFormat(null, 18, 0xffe00000, "center")) as FlxText;
            var scoreLabel:FlxText = add(new FlxText(demoTXT.x - 100, 0, 100, "Score").setFormat(null, 18, 0xffffff, "right")) as FlxText;
            scoreTxt = add(new FlxText(scoreLabel.x - 50, scoreLabel.height, 150, FlxG.score.toString()).setFormat(null, 18, 0xffe00000, "right")) as FlxText;
        }

        protected function startNextScreenTimer(value:Class, delay:int = 10000):void
        {
            nextScreen = value;
            nextScreenTimer = new Timer(delay, 1);
            nextScreenTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onNextScreen);
            nextScreenTimer.start();
        }

        protected function onNextScreen(event:TimerEvent = null):void
        {
            killNextScreenTimer();
            FlxG.state = new nextScreen();
        }

        protected function killNextScreenTimer():void
        {
            if (nextScreenTimer)
            {
                nextScreenTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onNextScreen);
                nextScreenTimer.stop();
                nextScreenTimer = null;
            }
        }

    }
}
