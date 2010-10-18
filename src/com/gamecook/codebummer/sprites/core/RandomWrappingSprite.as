/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 10/11/10
 * Time: 10:45 PM
 * To change this template use File | Settings | File Templates.
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
