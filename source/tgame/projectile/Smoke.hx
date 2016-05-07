package tgame.projectile;

import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import openfl.Assets;

/**
 * ...
 * @author q
 */
class Smoke extends FlxEmitter
{

	public function new(X:Float=0, Y:Float=0, Size:Int=0) 
	{
		super(X, Y, 10);
		//setRotation();
		makeParticles(new FlxSprite().makeGraphic(20,20,0x99222222).pixels, 10, 0, false, 0);
	}
	
}