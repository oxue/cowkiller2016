package tgame.critters;
import openfl.Assets;

/**
 * ...
 * @author qwerber
 */
class Human extends Critter
{

	public function new(X:Float=0, Y:Float=0, _graphic:Dynamic=null) 
	{
		super(X, Y, Assets.getBitmapData("assets/images/farmer.png", true));
		health = 20;
		setSpeed(20);
	}
	
}