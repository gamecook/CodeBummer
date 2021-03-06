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
    import com.gamecook.codebummer.sprites.core.RandomWrappingSprite;

    public class Person extends RandomWrappingSprite
    {
        public static const SPRITE_WIDTH:int = 40;
        public static const SPRITE_HEIGHT:int = 40;

        public static const TYPE_A:int = 0;
        public static const TYPE_B:int = 1;
        public static const TYPE_C:int = 2;
        public static const TYPE_D:int = 3;

        private var IDLE:String = "idle";
        private var WALK:String = "walk";

        private const TYPE_A_WALK:String = "typeAWalk";
        private const TYPE_B_WALK:String = "typeBWalk";
        private const TYPE_C_WALK:String = "typeCWalk";
        private const TYPE_D_WALK:String = "typeDWalk";

        /**
         * Simple sprite to represent a car. There are 4 types of cars, represented by TYPE_A, _B,
         * _C, and _D constant.
         *
         * @param x start X
         * @param y start Y
         * @param type type of person to use. Type_A, _b, and _c are referenced as constants on the class
         * @param direction the direction the sprite will move in
         * @param speed the speed in pixels in which the sprite will move on update
         */
        public function Person(x:Number, y:Number, direction:int, speed:int)
        {
            super(x, y, null, direction, speed, 4);
        }

        override protected function init():void
        {

            loadGraphic(GameAssets.PersonSpriteImage, true, true, SPRITE_WIDTH, SPRITE_HEIGHT);

            addAnimation(TYPE_A_WALK, [0,1,2], 15, true);
            addAnimation(TYPE_B_WALK, [3,4,5], 15, true);
            addAnimation(TYPE_C_WALK, [6,7,8], 15, true);
            addAnimation(TYPE_D_WALK, [9,10,11], 15, true);

            super.init();

            offset.x = 10;
            width = 20;

            play(WALK);
        }

        override public function changeType(value:int):void
        {
            switch (value)
            {
                case TYPE_A:
                    play(TYPE_A_WALK);
                    break;

                case TYPE_B:
                    play(TYPE_B_WALK);
                    break;

                case TYPE_C:
                    play(TYPE_C_WALK);
                    break;

                case TYPE_D:
                    play(TYPE_D_WALK);
                    break;
            }
        }
    }
}