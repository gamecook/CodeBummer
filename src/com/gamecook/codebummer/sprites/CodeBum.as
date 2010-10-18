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

package com.gamecook.codebummer.sprites
{
    import com.gamecook.codebummer.controls.TouchControls;
    import com.gamecook.codebummer.enum.GameStates;
    import com.gamecook.codebummer.enum.ScoreValues;
    import com.gamecook.codebummer.states.PlayState;

    import flash.geom.Point;

    import org.flixel.FlxG;
    import org.flixel.FlxSprite;

    public class CodeBum extends FlxSprite
    {

        private var startPosition:Point;
        private var moveX:int;
        private var maxMoveX:int;
        private var maxMoveY:int;
        private var targetX:Number;
        private var targetY:Number;
        private var animationFrames:int = 8;
        private var moveY:Number;
        private var state:PlayState;
        public var isMoving:Boolean;

        public var touchControls:TouchControls;

        //TODO this should probably extend Wrapping Sprite and override the off screen logic
        /**
         * The Frog represents the main player's character. This class contains all of the move, animation,
         * and some special collision logic for the Frog.
         *
         * @param X start X
         * @param Y start Y
         */
        public function CodeBum(X:Number, Y:Number)
        {
            super(X, Y);

            // Save the starting position to be used later when restarting
            startPosition = new Point(X, Y);

            // Calculate amount of pixels to move each turn
            moveX = 5;
            moveY = 5;
            maxMoveX = moveX * animationFrames;
            maxMoveY = moveY * animationFrames;

            // Set frog's target x,y to start position so he can move
            targetX = X;
            targetY = Y;

            // Set up sprite graphics and animations
            loadGraphic(GameAssets.CodeBumSpriteImage, true, false, 40, 40);

            addAnimation("idle" + DOWN, [0], 0, false);
            addAnimation("walk" + DOWN, [0,1,2], 15, true);

            addAnimation("idle" + UP, [3], 0, false);
            addAnimation("walk" + UP, [3,4,5], 15, true);

            addAnimation("idle" + RIGHT, [6], 0, false);
            addAnimation("walk" + RIGHT, [6,7,8], 15, true);

            addAnimation("idle" + LEFT, [9], 0, false);
            addAnimation("walk" + LEFT, [9,10,11], 15, true);

            addAnimation("die", [12, 13, 14, 15, 16], 2, false);

            offset.x = 10;
            offset.y = 0;
            width = 20;
            height = 40;

            // Set facing direction
            facing = FlxSprite.UP;

            // Save an instance of the PlayState to help with collision detection and movement 
            state = FlxG.state as PlayState;
        }

        /**
         * The main Frog update loop. This handles keyboard movement, collision and flagging id moving.
         */
        override public function update():void
        {

            // Test to see if the frog is dead and at the last death frame
            if (state.gameState == GameStates.COLLISION && (frame == 16))
            {
                // Flag game state that death animation is over and game can perform a restart
                state.gameState = GameStates.DEATH_OVER;
            } else if (state.gameState == GameStates.PLAYING)
            {
                // Test to see if TargetX and Y are equil. If so, Frog is free to move.
                if (x == targetX && y == targetY)
                {
                    // Checks to see what key was just pressed and sets the target X or Y to the new position
                    // along with what direction to face
                    if ((FlxG.keys.justPressed("LEFT") || (touchControls != null && touchControls.justPressed(2))) && x > 40)
                    {
                        targetX = x - maxMoveX;
                        facing = LEFT;
                    } else if ((FlxG.keys.justPressed("RIGHT") || (touchControls != null && touchControls.justPressed(3))) && x < FlxG.width - 40)
                    {
                        targetX = x + maxMoveX;
                        facing = RIGHT;
                    } else if ((FlxG.keys.justPressed("UP") || (touchControls != null && touchControls.justPressed(0))) && y > 40)
                    {
                        targetY = y - maxMoveY;
                        facing = UP;
                    } else if ((FlxG.keys.justPressed("DOWN") || (touchControls != null && touchControls.justPressed(1))) && y < 560)
                    {
                        targetY = y + maxMoveY;
                        facing = DOWN;
                    }

                    // See if we are moving
                    if (x != targetX || y != targetY)
                    {
                        //Looks like we are moving so play sound, flag isMoving and add to score.
                        FlxG.play(GameAssets.JumpSound);

                        // Once this flag is set, the frog will not take keyboard input until it has reacged it's target
                        isMoving = true;

                        // Add to score for moving
                        FlxG.score += ScoreValues.STEP;
                    } else
                    {
                        // Nope, we are not moving so flag isMoving and show Idle.
                        isMoving = false;

                    }

                }

                // If isMoving is true we are going to update the actual position.
                if (isMoving == true)
                {
                    if (facing == LEFT)
                    {
                        x -= moveX;
                    } else if (facing == RIGHT)
                    {
                        x += moveX;
                    } else if (facing == UP)
                    {
                        y -= moveY;
                    } else if (facing == DOWN)
                    {
                        y += moveY;
                    }

                    // Play the walking animation
                    play("walk" + facing);

                } else
                {
                    // nothing is happening so go back to idle animation
                    play("idle" + facing);
                }

            }

            //Default object physics update
            super.update();
        }

        /**
         * Simply plays the death animation
         */
        public function death():void
        {
            //TODO this should probably contain the logic for playing the death sound. Will need to know if it water or car
            play("die");
        }

        /**
         * This resets core values of the Frog instance.
         */
        public function restart():void
        {
            isMoving = false;
            x = startPosition.x;
            y = startPosition.y;
            targetX = startPosition.x;
            targetY = startPosition.y;
            facing = UP;
            play("idle" + facing);
            if (!visible) visible = true;

        }

        /**
         * This handles moving the Frog in the same direction as any instance it is resting on.
         *
         * @param speed the speed in pixels the Frog should move
         * @param facing the direction the frog will float in
         */
        public function float(speed:int, facing:uint):void
        {
            if (isMoving != true)
            {
                x += (facing == RIGHT) ? speed : -speed;
                targetX = x;
                isMoving = true;
            }
        }
    }
}
