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
    import com.gamecook.codebummer.controls.TouchControls;
    import com.gamecook.codebummer.enum.GameStates;
    import com.gamecook.codebummer.enum.ScoreValues;
    import com.gamecook.codebummer.sprites.Barrel;
    import com.gamecook.codebummer.sprites.Body;
    import com.gamecook.codebummer.sprites.Car;
    import com.gamecook.codebummer.sprites.Client;
    import com.gamecook.codebummer.sprites.CodeBum;
    import com.gamecook.codebummer.sprites.GameAssets;
    import com.gamecook.codebummer.sprites.Person;
    import com.gamecook.codebummer.sprites.Truck;
    import com.gamecook.codebummer.sprites.Wood;
    import com.gamecook.codebummer.sprites.core.TimerSprite;
    import com.gamecook.codebummer.sprites.core.WrappingSprite;

    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;
    import org.flixel.FlxText;
    import org.flixel.FlxU;

    public class PlayState extends BaseState
    {

        private const LIFE_X:int = 10;
        private const LIFE_Y:int = 650;
        private const TIMER_BAR_WIDTH:int = 310;
        private const TIMER_BAR_HEIGHT:int = 20;
        private const TILE_SIZE:int = 40;
        public var gameState:uint;

        private var player:CodeBum;
        private var WoodGroup:FlxGroup;
        private var carGroup:FlxGroup;
        private var turtleGroup:FlxGroup;
        private var timerBar:FlxSprite;
        private var gameTime:int;
        private var timer:int;
        private var waterY:int;
        private var lifeSprites:Array = [];
        private var clientsGroup:FlxGroup;
        private var timerBarBackground:FlxSprite;
        private var timeTxt:FlxText;
        private var playerIsFloating:Boolean;
        private var safeFrogs:int = 0;
        private var messageText:FlxText;
        private var gameMessageGroup:FlxGroup;
        private var hideGameMessageDelay:int = -1;
        private var timeAlmostOverFlag:Boolean = false;
        private var timeAlmostOverWarning:int;
        private var clients:Array;

        private var touchControls:TouchControls;
        private var actorSpeed:int = 1;
        private var lastLifeScore:int = 0;
        private var nextLife:int = 5000;
        private const ACTOR_Y_OFFSET:int = -13;


        /**
         * This is the main method responsible for creating all of the game pieces and layout out the level.
         */
        override public function create():void
        {
            super.create();

            // Create the BG sprites

            add(new FlxSprite(0, calculateTile(6), GameAssets.Background));
            add(new FlxSprite(60, calculateTile(2), GameAssets.BaseGround));

            //TODO Need to simplify level
            FlxG.level ++;

            // Set up main variable properties
            gameTime = (60 - FlxG.level) * 30;
            timer = gameTime;
            timeAlmostOverWarning = TIMER_BAR_WIDTH * .7;
            waterY = calculateTile(5);

            createLives(3);

            CONFIG::mobile
            {
                actorSpeed = 2;
            }

            //FlxG.showBounds = true;

            // Create home bases sprites and an array to store references to them
            clients = new Array();
            clientsGroup = new FlxGroup();
            add(clientsGroup);
            clients.push(clientsGroup.add(new Client(calculateTile(2) - 10, calculateTile(2, (ACTOR_Y_OFFSET * 3)), Client.TYPE_A, 200, 200)));
            clients.push(clientsGroup.add(new Client(calculateTile(4) - 10, calculateTile(2, (ACTOR_Y_OFFSET * 3)), Client.TYPE_B, 200, 200)));
            clients.push(clientsGroup.add(new Client(calculateTile(6) - 10, calculateTile(2, (ACTOR_Y_OFFSET * 3)), Client.TYPE_C, 200, 200)));
            clients.push(clientsGroup.add(new Client(calculateTile(8) - 10, calculateTile(2, (ACTOR_Y_OFFSET * 3)), Client.TYPE_D, 200, 200)));
            clients.push(clientsGroup.add(new Client(calculateTile(10) - 10, calculateTile(2, (ACTOR_Y_OFFSET * 3)), Client.TYPE_E, 200, 200)));

            // Create Woods and turtles
            WoodGroup = add(new FlxGroup()) as FlxGroup;
            turtleGroup = add(new FlxGroup()) as FlxGroup;

            WoodGroup.add(new Wood(calculateTile(0), calculateTile(3), Wood.TYPE_C, FlxSprite.RIGHT, actorSpeed));
            if (FlxG.level < 5)
                WoodGroup.add(new Wood(calculateTile(5), calculateTile(3), Wood.TYPE_C, FlxSprite.RIGHT, actorSpeed));
            WoodGroup.add(new Wood(calculateTile(10), calculateTile(3), Wood.TYPE_C, FlxSprite.RIGHT, actorSpeed));

            turtleGroup.add(new Body(calculateTile(0), calculateTile(4), Body.DEFAULT_TIME, 300, FlxSprite.LEFT, actorSpeed));
            if (FlxG.level < 10)
                turtleGroup.add(new Barrel(calculateTile(4), calculateTile(4), FlxSprite.LEFT, actorSpeed));
            turtleGroup.add(new Body(calculateTile(9), calculateTile(4), Body.DEFAULT_TIME, 100, FlxSprite.LEFT, actorSpeed));
            //turtleGroup.add(new Barrel(calculateTile(12), calculateTile(4), FlxSprite.LEFT, actorSpeed));

            WoodGroup.add(new Wood(30, calculateTile(5), Wood.TYPE_B, FlxSprite.RIGHT, actorSpeed * 2));
            WoodGroup.add(new Wood(Wood.TYPE_B_WIDTH + 130, calculateTile(5), Wood.TYPE_B, FlxSprite.RIGHT, actorSpeed * 2));

            // Create game message, this handles game over, time, and start message for player
            gameMessageGroup = new FlxGroup();
            gameMessageGroup.x = (FlxG.width - 150) * .5;
            gameMessageGroup.y = calculateTile(10) + 5;
            add(gameMessageGroup);

            // Create Player
            player = add(new CodeBum(calculateTile(6) + 10, calculateTile(15, ACTOR_Y_OFFSET))) as CodeBum;

            // Create Cars
            carGroup = add(new FlxGroup()) as FlxGroup;

            carGroup.add(new Truck(0, calculateTile(8, ACTOR_Y_OFFSET), FlxSprite.LEFT, actorSpeed));
            if (FlxG.level > 2)
                carGroup.add(new Truck(270, calculateTile(8, ACTOR_Y_OFFSET), FlxSprite.LEFT, actorSpeed));

            carGroup.add(new Car(0, calculateTile(9, ACTOR_Y_OFFSET), FlxSprite.RIGHT, actorSpeed * 2));
            carGroup.add(new Car(270, calculateTile(9, ACTOR_Y_OFFSET), FlxSprite.RIGHT, actorSpeed * 2));

            carGroup.add(new Car(0, calculateTile(11, ACTOR_Y_OFFSET), FlxSprite.RIGHT, actorSpeed));
            if (FlxG.level > 8)
                carGroup.add(new Car((Car.SPRITE_WIDTH + 138) * 1, calculateTile(11, ACTOR_Y_OFFSET), FlxSprite.RIGHT, actorSpeed));
            carGroup.add(new Car((Car.SPRITE_WIDTH + 138) * 2, calculateTile(11, ACTOR_Y_OFFSET), FlxSprite.RIGHT, actorSpeed));

            carGroup.add(new Car(0, calculateTile(12, ACTOR_Y_OFFSET), FlxSprite.LEFT, actorSpeed));
            if (FlxG.level > 9)
                carGroup.add(new Car((Car.SPRITE_WIDTH + 138) * 1, calculateTile(12, ACTOR_Y_OFFSET), FlxSprite.LEFT, actorSpeed));
            carGroup.add(new Car((Car.SPRITE_WIDTH + 138) * 2, calculateTile(12, ACTOR_Y_OFFSET), FlxSprite.LEFT, actorSpeed));

            carGroup.add(new Person(calculateTile(0), calculateTile(7, ACTOR_Y_OFFSET), FlxSprite.LEFT, actorSpeed));
            if (FlxG.level > 11)
                carGroup.add(new Person(calculateTile(5), calculateTile(7, ACTOR_Y_OFFSET), FlxSprite.LEFT, actorSpeed));
            carGroup.add(new Person(calculateTile(10), calculateTile(7, ACTOR_Y_OFFSET), FlxSprite.LEFT, actorSpeed));

            carGroup.add(new Person(calculateTile(0), calculateTile(13, ACTOR_Y_OFFSET), FlxSprite.RIGHT, actorSpeed));
            if (FlxG.level > 3)
                carGroup.add(new Person(calculateTile(3), calculateTile(13, ACTOR_Y_OFFSET), FlxSprite.RIGHT, actorSpeed));
            if (FlxG.level > 6)
                carGroup.add(new Person(calculateTile(6), calculateTile(13, ACTOR_Y_OFFSET), FlxSprite.RIGHT, actorSpeed));
            carGroup.add(new Person(calculateTile(9), calculateTile(13, ACTOR_Y_OFFSET), FlxSprite.RIGHT, actorSpeed));

            carGroup.add(new Person(calculateTile(0), calculateTile(14, ACTOR_Y_OFFSET), FlxSprite.LEFT, actorSpeed));
            if (FlxG.level > 4)
                carGroup.add(new Person(calculateTile(5), calculateTile(14, ACTOR_Y_OFFSET), FlxSprite.LEFT, actorSpeed));
            carGroup.add(new Person(calculateTile(10), calculateTile(14, ACTOR_Y_OFFSET), FlxSprite.LEFT, actorSpeed));


            // Black background for message
            var messageBG:FlxSprite = new FlxSprite(0, 0);
            messageBG.createGraphic(150, 30, 0xff000000);
            gameMessageGroup.add(messageBG);

            // Message text
            messageText = new FlxText(0, 4, 150, "TIME 99").setFormat(null, 18, 0xffff00000, "center");
            gameMessageGroup.visible = false;
            gameMessageGroup.add(messageText);


            // Create timer graphic
            //TODO this is hacky and needs to be cleaned up
            timerBarBackground = new FlxSprite(FlxG.width - TIMER_BAR_WIDTH - 10, LIFE_Y + 7);
            timerBarBackground.createGraphic(TIMER_BAR_WIDTH, TIMER_BAR_HEIGHT, 0xff693f2f);
            add(timerBarBackground);

            timerBar = new FlxSprite(timerBarBackground.x, timerBarBackground.y);
            timerBar.createGraphic(1, TIMER_BAR_HEIGHT, 0xFF000000);
            timerBar.scrollFactor.x = timerBar.scrollFactor.y = 0;
            timerBar.origin.x = timerBar.origin.y = 0;
            timerBar.scale.x = 0;
            add(timerBar);


            // Create Time text
            timeTxt = new FlxText(timerBarBackground.x + timerBarBackground.width - 65, timerBarBackground.y, 60, "TIME").setFormat(null, 14, 0xFFFFFFFF, "right");
            add(timeTxt);

            // Mobile specific code goes here
            /*FDT_IGNORE*/
            CONFIG::mobile
            {
                /*FDT_IGNORE*/
                touchControls = new TouchControls(this, 10, calculateTile(17) + 20, 16);
                player.touchControls = touchControls;
                add(touchControls);


                /*FDT_IGNORE*/
            }
            /*FDT_IGNORE*/

            // Activate game by setting the correct state
            gameState = GameStates.PLAYING;

            showLevelMessage();


        }


        /**
         * Helper function to find the Y position of a row on the game's grid
         * @param value row number
         * @return returns number based on the value * TILE_SIZE
         */
        public function calculateTile(value:int, offset:int = 0):int
        {
            return (value * TILE_SIZE) + offset;
        }

        /**
         * This is the main game loop. It goes through, analyzes the game state and performs collision detection.
         */
        override public function update():void
        {

            //TODO these first two condition based on hideGameMessageDelay can be cleaned up.
            if (gameState == GameStates.GAME_OVER)
            {
                if (hideGameMessageDelay == 0)
                {
                    //FlxG.state = new StartState();
                    FlxG.state = new ScoreState();
                } else
                {
                    hideGameMessageDelay -= FlxG.elapsed;
                }
            } else if (gameState == GameStates.LEVEL_OVER)
            {
                if (hideGameMessageDelay == 0)
                {
                    FlxG.state = new PlayState();
                } else
                {
                    hideGameMessageDelay -= FlxG.elapsed;
                }
            } else if (gameState == GameStates.PLAYING)
            {
                // Reset floating flag for the player.
                playerIsFloating = false;

                // Do collision detections
                FlxU.overlap(carGroup, player, carCollision);
                FlxU.overlap(WoodGroup, player, float);
                FlxU.overlap(turtleGroup, player, turtleFloat);
                FlxU.overlap(clientsGroup, player, baseCollision);

                // If nothing has collided with the player, test to see if they are out of bounds when in the water zone
                if (player.y < waterY)
                {
                    //TODO this can be cleaned up better
                    if (!player.isMoving && !playerIsFloating)
                        waterCollision();

                    if ((player.x > FlxG.width) || (player.x < -TILE_SIZE ))
                    {
                        waterCollision();
                    }

                }

                // This checks to see if time has run out. If not we decrease time based on what has elapsed
                // sine the last update. 
                if (timer == 0 && gameState == GameStates.PLAYING)
                {
                    timeUp();
                } else
                {
                    timer -= FlxG.elapsed;
                    timerBar.scale.x = TIMER_BAR_WIDTH - Math.round((timer / gameTime * TIMER_BAR_WIDTH));

                    if (timerBar.scale.x == timeAlmostOverWarning && !timeAlmostOverFlag)
                    {
                        FlxG.play(GameAssets.TimeAlmostUpSound);
                        timeAlmostOverFlag = true;
                    }
                }

                // Manage hiding gameMessage based on timer
                if (hideGameMessageDelay > 0)
                {
                    hideGameMessageDelay -= FlxG.elapsed;
                    if (hideGameMessageDelay < 0) hideGameMessageDelay = 0;
                } else if (hideGameMessageDelay == 0)
                {
                    hideGameMessageDelay = -1;
                    gameMessageGroup.visible = false;
                }

                // Update the score text
                scoreTxt.text = FlxG.score.toString();
            } else if (gameState == GameStates.DEATH_OVER)
            {
                restart();
            }

            if (lastLifeScore != FlxG.score && FlxG.score % nextLife == 0)
            {

                if (lifeSprites.length < 5)
                {
                    addLife();
                    lastLifeScore = FlxG.score;

                    messageText.text = "1-UP";
                    gameMessageGroup.visible = true;
                    hideGameMessageDelay = 200;
                    FlxG.play(GameAssets.LevelUpSound);
                }
            }
            // Update the entire game
            super.update();
        }

        /**
         * This is called when time runs out.
         */
        private function timeUp():void
        {
            if (gameState != GameStates.COLLISION)
            {
                FlxG.play(GameAssets.DeathSound);
                killPlayer();
            }
        }

        /**
         * This is called when the player dies in water.
         */
        private function waterCollision():void
        {
            if (gameState != GameStates.COLLISION)
            {
                FlxG.play(GameAssets.DrownSound);
                killPlayer();
            }
        }

        /**
         * This handles collision with a car.
         * @param target this instance that has collided with the player
         * @param player a reference to the player
         */
        private function carCollision(target:FlxSprite, player:CodeBum):void
        {
            if (gameState != GameStates.COLLISION)
            {
                FlxG.play(GameAssets.DeathSound);
                killPlayer();
            }
        }

        /**
         * This handles collision with a home base.
         * @param target this instance that has collided with the player
         * @param player a reference to the player
         */
        private function baseCollision(target:Client, player:CodeBum):void
        {

            switch (target.mode)
            {

                case Client.EMPTY: case Client.BONUS:
                // Increment number of frogs saved
                safeFrogs ++;

                // Flag the target as success to show it is occupied now
                target.success();

                var timeLeftOver:int = Math.round(timer / FlxG.framerate);

                // Increment the score based on the time left
                FlxG.score += timeLeftOver * ScoreValues.TIME_BONUS;

                if (target.mode == Client.BONUS)
                    FlxG.score += ScoreValues.HOME_BONUS;
                break;
                /*case Client.NO_BONUS:
                 waterCollision();
                 return;*/
                break;

            }


            // Reguardless if the base was empty or occupied we still display the time it took to get there
            messageText.text = "TIME " + String(gameTime / FlxG.framerate - timeLeftOver);
            gameMessageGroup.visible = true;
            hideGameMessageDelay = 200;

            // Test to see if we have all the frogs, if so then level has been completed. If not restart.
            if (safeFrogs == clients.length)
            {
                levelComplete();
            } else
            {
                restart();
            }

        }

        /**
         * This is called when a level is completed
         */
        private function levelComplete():void
        {

            //Increment the score based on
            FlxG.score += ScoreValues.FINISH_LEVEL;

            // Change game state to let system know a level has been completed
            gameState = GameStates.LEVEL_OVER;

            // Hide the player since the level is over and wait for the game to restart itself
            player.visible = false;
        }

        /**
         * This is called when a player is on a Wood to indicate the frog needs to float
         * @param target this is the instance that collided with the player
         * @param player an instance of the player
         */
        private function turtleFloat(target:TimerSprite, player:CodeBum):void
        {
            // Test to see if the target is active. If it is active the player can float. If not the player
            // is in the water 
            if (target.isActive)
            {
                float(target, player);
            } else if (!player.isMoving)
            {
                waterCollision();
            }
        }

        /**
         * This handles floating the player sprite with the target it is on.
         * @param target this is the instance that collided with the player
         * @param player an instance of the player
         */
        private function float(target:WrappingSprite, player:CodeBum):void
        {
            playerIsFloating = true;

            if (!(FlxG.keys.LEFT || FlxG.keys.RIGHT))
            {
                player.float(target.speed, target.facing);
            }
        }

        /**
         * This handles resetting game values when a frog dies, or a level is completed.
         */
        private function restart():void
        {
            // Make sure the player still has lives to restart
            if (totalLives == 0 && gameState != GameStates.GAME_OVER)
            {
                gameOver();
            } else
            {
                // Test to see if Level is over, if so reset all the bases.
                if (gameState == GameStates.LEVEL_OVER)
                    resetBases();

                // Change game state to Playing so animation can continue.
                gameState = GameStates.PLAYING;
                timer = gameTime;
                player.restart();
                timeAlmostOverFlag = false;
            }
        }

        /**
         * This loops through the bases and makes sure they are set to empty.
         */
        private function resetBases():void
        {
            // Loop though bases and empty them
            for each (var base:Client in clients)
            {
                trace("base", base);
                base.empty();
            }

            // Reset safe frogs
            safeFrogs = 0;

            showLevelMessage();
        }

        private function showLevelMessage():void
        {
// Set message to tell player they can restart
            messageText.text = "LEVEL " + FlxG.level;
            gameMessageGroup.visible = true;
            hideGameMessageDelay = 200;
        }

        /**
         * This kills the player. Game state is set to collision so everything knows to pause and a life is removed.
         */
        private function killPlayer():void
        {
            gameState = GameStates.COLLISION;
            removeLife();
            player.death();
        }

        /**
         * This is called when a game is over. A message is shown and the game locks down until it is ready to go
         * back to the start screen
         */
        private function gameOver():void
        {
            gameState = GameStates.GAME_OVER;

            gameMessageGroup.visible = true;

            messageText.text = "GAME OVER";

            hideGameMessageDelay = 100;

            //TODO there is a Game Over sound I need to play here
        }

        /**
         * This loop creates X number of lives.
         * @param value number of lives to create
         */
        private function createLives(value:int):void
        {
            var i:int;

            for (i = 0; i < value; i++)
            {
                addLife();
            }
        }

        /**
         * This adds a life sprite to the display and pushes it to teh lifeSprites array.
         * @param value
         */
        private function addLife():void
        {
            var flxLife:FlxSprite = new FlxSprite((totalLives * (23 + 10)) + LIFE_X, LIFE_Y, GameAssets.LivesSprite);
            add(flxLife);
            lifeSprites.push(flxLife);
        }

        /**
         * This removes the life sprite from the display and from the lifeSprites array as well.
         * @param value
         */
        private function removeLife():void
        {
            var id:int = totalLives - 1;
            var sprite:FlxSprite = lifeSprites[id];
            sprite.kill();
            lifeSprites.splice(id, 1);
        }

        /**
         * A simple getter for Total Lives based on life sprite instances in lifeSprites array.
         * @return
         */
        private function get totalLives():int
        {
            return lifeSprites.length;
        }
    }
}
