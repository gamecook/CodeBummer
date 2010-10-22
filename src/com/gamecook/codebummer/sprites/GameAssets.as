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

    public class GameAssets
    {

        [Embed(source="../../../../../build/assets/background.png")]
        public static var Background:Class;

        [Embed(source="../../../../../build/assets/lives.png")]
        public static var LivesSprite:Class;

        [Embed(source="../../../../../build/assets/car.png")]
        public static var CarSpriteImage:Class;

        [Embed(source="../../../../../build/assets/bum.png")]
        public static var CodeBumSpriteImage:Class;

        [Embed(source="../../../../../build/assets/client.png")]
        public static var HomeSpriteImage:Class;

        [Embed(source="../../../../../build/assets/wood_small.png")]
        public static var LogSpriteImage1:Class;

        [Embed(source="../../../../../build/assets/wood_medium.png")]
        public static var LogSpriteImage2:Class;

        [Embed(source="../../../../../build/assets/wood_large.png")]
        public static var LogSpriteImage3:Class;

        [Embed(source="../../../../../build/assets/truck.png")]
        public static var TruckSpriteImage:Class;

        [Embed(source="../../../../../build/assets/bodies.png")]
        public static var BodySpriteImage:Class;

        [Embed(source="../../../../../build/assets/people.png")]
        public static var PersonSpriteImage:Class;

        [Embed(source="../../../../../build/assets/barrel.png")]
        public static var BarrelSpriteImage:Class;

        [Embed(source="../../../../../build/assets/base_ground.png")]
        public static var BaseGround:Class;

        [Embed(source="../../../../../build/assets/skyline.png")]
        public static var Skyline:Class;

        [Embed(source="../../../../../build/assets/logo.png")]
        public static var TitleSprite:Class;

        [Embed(source="../../../../../build/assets/about.png")]
        public static var About:Class;

        [Embed(source="../../../../../build/assets/credits.png")]
        public static var CreditPhotos:Class;

        // Sounds

        [Embed(source="../../../../../build/assets/sounds.swf", symbol="ThemeSound")]
        public static var ThemeSound:Class;

        [Embed(source="../../../../../build/assets/sounds.swf", symbol="LevelUp")]
        public static var LevelUpSound:Class;

        [Embed(source="../../../../../build/assets/sounds.swf", symbol="Drowner")]
        public static var DrownSound:Class;

        [Embed(source="../../../../../build/assets/sounds.swf", symbol="Death")]
        public static var DeathSound:Class;

        [Embed(source="../../../../../build/assets/sounds.swf", symbol="TimeIsAlmostUp")]
        public static var TimeAlmostUpSound:Class;

        [Embed(source="../../../../../build/assets/sounds.swf", symbol="Jump")]
        public static var JumpSound:Class;

    }
}
