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

package com.gamecook.codebummer.sprites.core
{
    import org.flixel.FlxU;

    public class RandomWrappingSprite extends WrappingSprite
    {

        protected var totalTypes:int = 1;

        public function RandomWrappingSprite(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null, dir:uint = RIGHT, speed:int = 1, totalTypes:int = 1)
        {

            this.totalTypes = totalTypes;

            super(X, Y, SimpleGraphic, dir, speed);

            init()

        }

        protected function init():void
        {
            selectRandomType();
        }


        override protected function onRestartLeft():void
        {
            super.onRestartLeft();
            selectRandomType();
        }

        override protected function onRestartRight():void
        {
            super.onRestartRight();
            selectRandomType();
        }

        protected function selectRandomType():void
        {
            var newTypeID:int = FlxU.random(true) * totalTypes;
            changeType(newTypeID);
        }

        public function changeType(value:int):void
        {
            // This needs to be fleshed out
        }
    }
}
