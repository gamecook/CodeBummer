/**
 * Created by IntelliJ IDEA.
 * User: jfreeman
 * Date: 10/16/10
 * Time: 12:42 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.codebummer.sprites
{
    import com.gamecook.codebummer.sprites.core.*;

    public class Barrel extends TimerSprite
    {
        public function Barrel(x:Number, y:Number, direction:uint, velocity:int)
        {
            super(x, y, GameAssets.BarrelSpriteImage, -1, -1, direction, velocity);

            offset.y = -10;

        }
    }
}
